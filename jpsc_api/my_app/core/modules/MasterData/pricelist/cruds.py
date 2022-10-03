from fastapi import HTTPException, status
from typing import Any, List
from sqlmodel import func, and_
from sqlalchemy.exc import SQLAlchemyError
from fastapi_sqlalchemy import db
from my_app.core.modules.MasterData.item.models import Item

from my_app.shared.crud import CRUDBase

from .schemas_header import (
    PricelistHeaderCreate,
    PricelistHeaderRead,
    PricelistHeaderUpdate,
)
from .schemas_row import PricelistRowUpdate
from .models import PricelistHeader, PricelistRow
from ..branch import models


class CRUDPricelist(
    CRUDBase[
        PricelistHeader,
        PricelistHeaderCreate,
        PricelistHeaderUpdate,
        PricelistHeaderRead,
    ]
):
    def create(self, *, create_schema: PricelistHeaderCreate, user_id: int):
        try:

            header_obj = (
                db.session.query(self.model)
                .filter(func.lower(self.model.code) == create_schema.code.lower())
                .first()
            )
            if header_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Pricelist code already exist.",
                )

            db_obj = self.model(**create_schema.dict())
            db_obj.created_by = user_id

            db.session.add(db_obj)
            db.session.commit()
            db.session.refresh(db_obj)
            return db_obj

        except SQLAlchemyError as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))

    def get_all(
        self,
        *,
        is_active: bool = True,
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(self.model.is_active.is_(is_active))
            .order_by(self.model.code)
            .all()
        )
        return db_obj

    def get_item_price_by_branch(
        self,
        *,
        branch_code: str,
    ) -> Any:
        branch_obj = db.session.query(models.Branch).get(branch_code)
        if not branch_obj:
            raise HTTPException(status_code=404, detail="Invalid branch code.")
        pricelist_row_obj = (
            db.session.query(PricelistRow)
            .join(Item, Item.code == PricelistRow.item_code)
            .filter(
                and_(
                    PricelistRow.pricelist_code == branch_obj.pricelist_code,
                    Item.is_active.is_(True),
                )
            )
            .all()
        )
        if not pricelist_row_obj:
            raise HTTPException(
                status_code=404,
                detail=f"{branch_code.capitalize()} has no pricelist assign.",
            )
        return pricelist_row_obj

    def update_rows(
        self,
        *,
        pricelistRows: List[PricelistRowUpdate],
        user_id: int,
    ) -> Any:

        list_object_dict = []
        for i in pricelistRows:
            rows = i.dict()
            rows["updated_by"] = user_id
            list_object_dict.append(rows)

        db.session.bulk_update_mappings(PricelistRow, list_object_dict)
        db.session.commit()

        return "Successfully update."


crud_pricelist = CRUDPricelist(model=PricelistHeader)
