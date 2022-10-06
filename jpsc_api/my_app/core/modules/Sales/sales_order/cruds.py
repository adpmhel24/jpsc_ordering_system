from datetime import date, datetime
from fastapi import HTTPException, status
from typing import Any, Optional
from sqlmodel import and_, or_, cast, DATE
from sqlalchemy.exc import SQLAlchemyError
from fastapi.encoders import jsonable_encoder
from fastapi_sqlalchemy import db
from pydantic import condecimal

from my_app.shared.crud import CRUDBase
from my_app.shared.custom_enums import DocstatusEnum, OrderStatusEnum
from my_app.core.modules.MasterData.branch.cruds import crud_branch
from my_app.core.modules.MasterData.item.cruds import crud_item
from .schemas_header import (
    SalesOrderHeaderCreate,
    SalesOrderHeaderRead,
    SalesOrderHeaderUpdate,
)
from .schemas_row import SalesOrderRowCreate
from .schemas_so_comment import SalesOrderCommentCreate
from .models import SalesOrderHeader, SalesOrderRow, SalesOrderComment


class CRUDSalesOrder(
    CRUDBase[
        SalesOrderHeader,
        SalesOrderHeaderCreate,
        SalesOrderHeaderUpdate,
        SalesOrderHeaderRead,
    ]
):
    def create(
        self,
        *,
        header_schema: SalesOrderHeaderCreate,
        rows_schema: list[SalesOrderRowCreate],
        user_id: int,
    ) -> Any:

        try:

            db_header_obj: SalesOrderHeader = self.model(**header_schema.dict())
            db_header_obj.created_by = user_id

            db_header_obj.subtotal: condecimal = 0
            for row in rows_schema:

                # Check item_name if exist it will raise an error if invalid
                item_obj = crud_item.get(fk=row.item_code)
                if not item_obj:
                    raise HTTPException(status_code=404, detail="Invalid Item code.")

                db_row_obj = SalesOrderRow(**row.dict())
                db_row_obj.linetotal = row.unit_price * row.quantity
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
            db_header_obj.reference = f"Order-{branch_obj.series_code.upper()}-{date.today().year}-{series_num}"

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
        order_status: Optional[OrderStatusEnum],
        from_date: Optional[str],
        to_date: Optional[str],
        branch: Optional[str],
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(order_status == None, self.model.order_status == order_status),
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
        order_status: Optional[OrderStatusEnum],
    ):
        db_obj_length = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(order_status == None, self.model.order_status == order_status),
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
        order_status: Optional[int],
        from_date: Optional[str],
        to_date: Optional[str],
        user_id: int,
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(order_status == None, self.model.order_status == order_status),
                    or_(
                        from_date == "",
                        cast(self.model.delivery_date, DATE) >= from_date,
                    ),
                    or_(to_date == "", cast(self.model.delivery_date, DATE) <= to_date),
                    self.model.created_by == user_id,
                ),
            )
            .order_by(self.model.delivery_date)
            .all()
        )
        return db_obj

    def cancel(self, *, id: int, schema: SalesOrderCommentCreate, user_id: int) -> Any:
        db_obj: SalesOrderHeader = self.get(fk=id)
        if not db_obj:
            raise HTTPException(status_code=404, detail="Invalid id.")
        if db_obj.docstatus == DocstatusEnum.canceled:
            raise HTTPException(status_code=403, detail="Document already canceled.")

        db_obj.docstatus = DocstatusEnum.canceled
        db_obj.canceled_remarks = schema.comment
        db_obj.canceled_by = user_id
        db_obj.date_canceled = datetime.now()

        comment_obj = SalesOrderComment(**schema.dict())
        comment_obj.created_by = user_id
        db_obj.comments.append(comment_obj)

        db.session.commit()

        return db_obj

    def update(
        self,
        *,
        schema: SalesOrderHeaderUpdate,
        user_id: int,
    ) -> Any:

        try:
            header_dict = schema.dict()
            header_dict["updated_by"] = user_id
            header_dict["date_updated"] = datetime.now()
            rows_dict = header_dict.pop("rows")

            # query the header first
            sales_order_h_obj = db.session.query(self.model).filter_by(id=schema.id)

            if schema.order_status == 1:
                if sales_order_h_obj.first().order_status != 0:
                    raise HTTPException(
                        status_code=403, detail="You can't select 'Price Confirmed'!"
                    )
                header_dict["confirmed_by"] = user_id
                header_dict["date_confirmed"] = datetime.now()

            elif schema.order_status == 2:
                if sales_order_h_obj.first().order_status != 1:
                    raise HTTPException(
                        status_code=403,
                        detail="You can't select the order status to 'Credit Confirmed', please update the order status first to 'Price Confirmed' .",
                    )

                header_dict["confirmed_by"] = user_id
                header_dict["date_confirmed"] = datetime.now()

            elif schema.order_status == 3:
                if sales_order_h_obj.first().order_status != 2:
                    raise HTTPException(
                        status_code=403,
                        detail="You can't select the order status to 'Dispatched',  please update the order status first to 'Credit Confirmed' first.",
                    )
                header_dict["dispatched_by"] = user_id
                header_dict["docstatus"] = DocstatusEnum.closed
                header_dict["date_dispatched"] = datetime.now()

            sales_order_h_obj.update(header_dict)
            db.session.bulk_update_mappings(SalesOrderRow, rows_dict)
            db.session.commit()

            return "Successfully update."
        except SQLAlchemyError as err:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=jsonable_encoder(err.args[0].rstrip().split("\n")[0]),
            )


crud_so = CRUDSalesOrder(SalesOrderHeader)
