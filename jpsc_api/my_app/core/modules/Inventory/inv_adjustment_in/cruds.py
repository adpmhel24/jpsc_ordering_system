from datetime import date, datetime
from fastapi import HTTPException, status
from typing import Any, Optional
from sqlmodel import and_, or_, cast, DATE
from sqlalchemy.exc import SQLAlchemyError
from fastapi.encoders import jsonable_encoder
from fastapi_sqlalchemy import db

from my_app.shared.crud import CRUDBase
from my_app.shared.custom_enums import DocstatusEnum
from my_app.core.modules.MasterData.warehouse.cruds import crud_whse
from my_app.core.modules.MasterData.branch.cruds import crud_branch, BranchRead
from my_app.core.modules.MasterData.alt_uom.cruds import crud_altuom
from my_app.core.modules.MasterData.item.cruds import crud_item
from my_app.core.modules.Inventory.inv_adjustment_in.schemas_header import (
    InvAdjustmentInHeaderCreate,
    InvAdjustmentInHeaderRead,
    InvAdjustmentInHeaderUpdate,
    InvAdjustmentInHeaderCancel,
)
from my_app.core.modules.Inventory.inv_adjustment_in.schemas_row import (
    InvAdjustmentInRowCreate,
)
from my_app.core.modules.Inventory.inv_adjustment_in.models import (
    InvAdjustmentInHeader,
    InvAdjustmentInRow,
)


class CRUDAdjustmentIn(
    CRUDBase[
        InvAdjustmentInHeader,
        InvAdjustmentInHeaderCreate,
        InvAdjustmentInHeaderUpdate,
        InvAdjustmentInHeaderRead,
    ]
):
    def create(
        self,
        *,
        header_schema: InvAdjustmentInHeaderCreate,
        rows_schema: list[InvAdjustmentInRowCreate],
        user_id: int,
    ) -> Any:

        try:

            db_header_obj: InvAdjustmentInHeader = self.model(**header_schema.dict())
            db_header_obj.created_by = user_id

            for row in rows_schema:
                # Check whsename if exist
                whse_obj = crud_whse.get(fk=row.whsecode)
                if not whse_obj:
                    raise HTTPException(
                        status_code=status.HTTP_404_NOT_FOUND,
                        detail="Warehouse not found",
                    )

                row.whsecode2 = row.whsecode

                # Check item_name if exist
                item_obj = crud_item.get(fk=row.item_code)
                if not item_obj:
                    raise HTTPException(
                        status_code=status.HTTP_404_NOT_FOUND, detail="Item not found"
                    )

                # get the alt uom
                alt_uom_group = crud_altuom.filterBy(
                    filters={
                        "and": [
                            (
                                "uom_group_code",
                                "==",
                                item_obj.uom_group_code,
                            ),
                            (
                                "alt_uom",
                                "==",
                                row.uom,
                            ),
                        ]
                    },
                ).first()
                if not alt_uom_group:
                    raise HTTPException(
                        status_code=status.HTTP_404_NOT_FOUND,
                        detail="Alternative uom not found!",
                    )

                db_row_obj = InvAdjustmentInRow(**row.dict())
                db_row_obj.inv_qty = (
                    row.quantity * alt_uom_group.base_qty * alt_uom_group.alt_qty
                )
                db_header_obj.rows.append(db_row_obj)

            db.session.add(db_header_obj)

            # series
            branch_obj: BranchRead = crud_branch.get(fk=header_schema.branch)
            if not (branch_obj.series_code):
                raise Exception("No series code assigned to this branch!")
            series_num = f"{db_header_obj.id:07d}"
            db_header_obj.reference = f"INV_ADJ_IN-{branch_obj.series_code.upper()}-{date.today().year}-{series_num}"

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
        from_date: Optional[str],
        to_date: Optional[str],
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(
                        from_date == "",
                        cast(self.model.transdate, DATE) >= from_date,
                    ),
                    or_(to_date == "", cast(self.model.transdate, DATE) <= to_date),
                ),
            )
            .order_by(self.model.id.desc())
            .all()
        )
        return db_obj

    def cancel(
        self, *, id: int, schema: InvAdjustmentInHeaderCancel, user_id: int
    ) -> Any:
        db_obj: InvAdjustmentInHeader = self.get(fk=id)
        if not db_obj:
            raise HTTPException(status_code=404, detail="Invalid id.")
        if db_obj.docstatus == DocstatusEnum.canceled:
            raise HTTPException(status_code=403, detail="Document already canceled.")

        db_obj.docstatus = DocstatusEnum.canceled
        db_obj.canceled_by = user_id
        db_obj.canceled_remarks = schema.canceled_remarks
        db_obj.date_canceled = datetime.now()

        db.session.commit()

        return db_obj


crud_adj_in = CRUDAdjustmentIn(InvAdjustmentInHeader)
