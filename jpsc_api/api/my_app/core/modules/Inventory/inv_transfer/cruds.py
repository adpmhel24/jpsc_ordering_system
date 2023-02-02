from datetime import date
from fastapi import HTTPException, Query, status
from typing import Any, Dict, Optional
from sqlmodel import Session, func, and_, or_, cast, DATE
from fastapi.encoders import jsonable_encoder
from sqlalchemy.exc import SQLAlchemyError
from fastapi_sqlalchemy import db


from my_app.shared.crud import CRUDBase
from my_app.shared.custom_enums import DocstatusEnum
from ...MasterData.warehouse.cruds import crud_whse
from ...MasterData.alt_uom.cruds import crud_altuom
from ...MasterData.item.cruds import crud_item
from .models import InvTrfrHeader, InvTrfrRow
from .schemas_header import (
    InvTrfrHeaderCreate,
    InvTrfrHeaderRead,
    InvTrfrHeaderUpdate,
)
from .schemas_row import (
    InvTrfrRowCreate,
)


class CRUDInvTrfr(
    CRUDBase[
        InvTrfrHeader,
        InvTrfrHeaderCreate,
        InvTrfrHeaderUpdate,
        InvTrfrHeaderRead,
    ]
):
    def create(
        self,
        *,
        header_schema: InvTrfrHeaderCreate,
        rows_schema: list[InvTrfrRowCreate],
        user_id: int,
    ) -> Any:

        try:

            db_header_obj = self.model(**header_schema.dict())
            db_header_obj.created_by = user_id

            for row in rows_schema:
                # Check whsecode if exist
                from_whse_obj = crud_whse.get(fk=row.whsecode)
                to_whse_obj = crud_whse.get(fk=row.whsecode2)
                if not from_whse_obj:
                    raise HTTPException(
                        status_code=status.HTTP_404_NOT_FOUND,
                        detail="Invalid from warehouse not found",
                    )
                if not to_whse_obj:
                    raise HTTPException(
                        status_code=status.HTTP_404_NOT_FOUND,
                        detail="Invalid to warehouse not found",
                    )

                # Check item_code if exist
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

                db_row_obj = InvTrfrRow(**row.dict())
                db_row_obj.inv_qty = (
                    row.quantity * alt_uom_group.base_qty * alt_uom_group.alt_qty
                )

                db_row_obj.balance = db_row_obj.quantity
                db_header_obj.rows.append(db_row_obj)

            db.session.add(db_header_obj)
            db.session.commit()
            db.session.refresh(db_header_obj)
            return db_header_obj
        except SQLAlchemyError as err:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail=jsonable_encoder(err.args[0]),
            )

    def get_all(
        self,
        *,
        docstatus: Optional[DocstatusEnum],
        from_date: Optional[date],
        to_date: Optional[date],
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(docstatus == None, self.model.docstatus == docstatus),
                    or_(
                        from_date == None, cast(self.model.transdate, DATE) >= from_date
                    ),
                    or_(to_date == None, cast(self.model.transdate, DATE) <= to_date),
                ),
            )
            .order_by(self.model.id)
            .all()
        )
        return db_obj


crud_inv_trfr = CRUDInvTrfr(InvTrfrHeader)
