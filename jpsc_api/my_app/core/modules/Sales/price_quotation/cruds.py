from datetime import date, datetime
from fastapi import HTTPException, status
from typing import Any, Optional
from sqlmodel import and_, or_, cast, DATE
from sqlalchemy.exc import SQLAlchemyError
from fastapi.encoders import jsonable_encoder
from fastapi_sqlalchemy import db
from pydantic import condecimal

from my_app.shared.crud import CRUDBase
from my_app.shared.custom_enums import DocstatusEnum, PQStatusEnum
from my_app.core.modules.MasterData.branch.cruds import crud_branch
from my_app.core.modules.MasterData.item.cruds import crud_item
from .schemas_header import (
    PriceQuotationHeaderCreate,
    PriceQuotationHeaderRead,
    PriceQuotationHeaderUpdate,
)
from .schemas_row import PriceQuotationRowCreate
from .schemas_pq_comment import PriceQuotationCommentCreate
from .models import PriceQuotationHeader, PriceQuotationRow, PriceQuotationComment


class CRUDPriceQuotation(
    CRUDBase[
        PriceQuotationHeader,
        PriceQuotationHeaderCreate,
        PriceQuotationHeaderUpdate,
        PriceQuotationHeaderRead,
    ]
):
    def create(
        self,
        *,
        header_schema: PriceQuotationHeaderCreate,
        rows_schema: list[PriceQuotationRowCreate],
        user_id: int,
    ) -> Any:

        try:

            db_header_obj: PriceQuotationHeader = self.model(**header_schema.dict())
            db_header_obj.created_by = user_id

            db_header_obj.subtotal: condecimal = 0
            for row in rows_schema:

                # Check item_name if exist it will raise an error if invalid
                item_obj = crud_item.get(fk=row.item_code)
                if not item_obj:
                    raise HTTPException(status_code=404, detail="Invalid Item code.")

                db_row_obj = PriceQuotationRow(**row.dict())
                db_row_obj.linetotal = row.unit_price * row.quantity
                db_row_obj.item_description = item_obj.description
                db_header_obj.subtotal += db_row_obj.linetotal
                db_header_obj.rows.append(db_row_obj)

            db_header_obj.gross = (
                db_header_obj.subtotal + db_header_obj.delfee + db_header_obj.otherfee
            )
            db.session.add(db_header_obj)

            # series
            branch_obj = crud_branch.get(fk=header_schema.dispatching_branch)
            if not branch_obj:
                raise HTTPException(status_code=404, detail="Invalid branch code.")
            if not (branch_obj.series_code):
                raise Exception("No series code assigned to this branch!")
            series_num = f"{db_header_obj.id:07d}"
            db_header_obj.reference = (
                f"PQ-{branch_obj.series_code.upper()}-{date.today().year}-{series_num}"
            )

            db.session.add(db_header_obj)

            db.session.commit()
            db.session.refresh(db_header_obj)
            return db_header_obj

        except SQLAlchemyError as err:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=jsonable_encoder(err.args[0].rstrip().split("\n")[0]),
            )

    def get_all(
        self,
        *,
        docstatus: Optional[DocstatusEnum],
        pq_status: Optional[PQStatusEnum],
        from_date: Optional[str],
        to_date: Optional[str],
        branch: Optional[str],
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(pq_status == None, self.model.pq_status == pq_status),
                    or_(
                        from_date == "",
                        cast(self.model.transdate, DATE) >= from_date,
                    ),
                    or_(to_date == "", cast(self.model.transdate, DATE) <= to_date),
                    or_(branch == "", self.model.dispatching_branch == branch),
                ),
            )
            .order_by(self.model.id.desc())
            .all()
        )
        return db_obj

    def count_orders(
        self,
        *,
        docstatus: Optional[DocstatusEnum],
        pq_status: Optional[PQStatusEnum],
    ):
        db_obj_length = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(pq_status == None, self.model.pq_status == pq_status),
                ),
            )
            .order_by(self.model.id.desc())
            .count()
        )
        return db_obj_length

    def get_all_by_owner(
        self,
        *,
        docstatus: Optional[str],
        pq_status: Optional[int],
        from_date: Optional[str],
        to_date: Optional[str],
        user_id: int,
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(pq_status == None, self.model.pq_status == pq_status),
                    or_(
                        from_date == "",
                        cast(self.model.transdate, DATE) >= from_date,
                    ),
                    or_(to_date == "", cast(self.model.transdate, DATE) <= to_date),
                    self.model.created_by == user_id,
                ),
            )
            .order_by(self.model.delivery_date)
            .all()
        )
        return db_obj

    def cancel(
        self, *, id: int, schema: PriceQuotationCommentCreate, user_id: int
    ) -> Any:
        db_obj: PriceQuotationHeader = self.get(fk=id)
        if not db_obj:
            raise HTTPException(status_code=404, detail="Invalid id.")
        if db_obj.docstatus == DocstatusEnum.canceled:
            raise HTTPException(status_code=403, detail="Document already canceled.")

        db_obj.docstatus = DocstatusEnum.canceled
        db_obj.canceled_remarks = schema.comment
        db_obj.canceled_by = user_id
        db_obj.date_canceled = datetime.now()

        comment_obj = PriceQuotationComment(**schema.dict())
        comment_obj.created_by = user_id
        db_obj.comments.append(comment_obj)

        db.session.commit()

        return db_obj

    def update(
        self,
        *,
        schema: PriceQuotationHeaderUpdate,
        user_id: int,
    ) -> Any:

        try:
            header_dict = schema.dict()
            header_dict["updated_by"] = user_id
            header_dict["date_updated"] = datetime.now()
            rows_dict = header_dict.pop("rows")

            # query the header first
            price_quotation_h_obj = db.session.query(self.model).filter_by(id=schema.id)

            if schema.pq_status == 1:
                if price_quotation_h_obj.first().pq_status != 0:
                    raise HTTPException(
                        status_code=403, detail="You can't select 'Price Confirmed'!"
                    )
                header_dict["approved_by"] = user_id
                header_dict["date_approved"] = datetime.now()

            elif schema.pq_status == 2:
                if (
                    price_quotation_h_obj.first().pq_status != 1
                    and price_quotation_h_obj.first().pq_status != schema.pq_status
                ):
                    raise HTTPException(
                        status_code=403,
                        detail="You can't select the pq status to 'With SAP SQ', please update the pq status first to 'Price Confirmed' .",
                    )
                if not schema.sq_number:
                    raise HTTPException(
                        status_code=403, detail="SQ Number is required!"
                    )
                header_dict["confirmed_by"] = user_id
                header_dict["date_confirmed"] = datetime.now()

            elif schema.pq_status == 3:
                if (
                    price_quotation_h_obj.first().pq_status != 2
                    and price_quotation_h_obj.first().pq_status != schema.pq_status
                ):
                    raise HTTPException(
                        status_code=403,
                        detail="You can't select the order status to 'Dispatched',  please update the order status first to 'Credit Confirmed' first.",
                    )
                header_dict["dispatched_by"] = user_id
                header_dict["docstatus"] = DocstatusEnum.closed
                header_dict["date_dispatched"] = datetime.now()

            price_quotation_h_obj.update(header_dict)
            db.session.bulk_update_mappings(PriceQuotationRow, rows_dict)
            db.session.commit()

            return "Updated successfully."
        except SQLAlchemyError as err:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=jsonable_encoder(err.args[0].rstrip().split("\n")[0]),
            )


crud_pq = CRUDPriceQuotation(PriceQuotationHeader)
