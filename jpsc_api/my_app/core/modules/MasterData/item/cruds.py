from fastapi import HTTPException, status
from typing import Any, Dict, List, Union
from sqlmodel import func, and_
from sqlalchemy.exc import SQLAlchemyError
from fastapi_sqlalchemy import db
from my_app.core.modules.MasterData.pricelist.models import PricelistRow
from my_app.core.modules.MasterData.system_user.schemas import SystemUserCreate

from my_app.shared.crud import CRUDBase

from ..branch.cruds import crud_branch
from .schemas import ItemCreate, ItemUpdate, ItemRead
from .models import Item


class CRUDItem(CRUDBase[Item, ItemCreate, ItemUpdate, ItemRead]):
    def create(
        self,
        *,
        create_schema: ItemCreate,
        user_id: int,
    ) -> Any:

        try:
            # Check if uom code was passed is already exist
            item_obj = (
                db.session.query(self.model)
                .filter(func.lower(self.model.code) == create_schema.code.lower())
                .first()
            )
            if item_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Item code already exist.",
                )

            # create schema model to dict
            c_dict = create_schema.dict()

            db_obj = self.model(**c_dict)
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

    def get_items_with_price_by_branch(self, *, branch_code: str):
        branch_obj = crud_branch.get(branch_code)
        if not branch_code:
            raise HTTPException(status_code=404, detail="Invalid branch code!")
        items_obj = (
            db.session.query(
                self.model.code,
                self.model.description,
                self.model.item_group_code,
                self.model.sale_uom_code,
                PricelistRow.price,
            )
            .join(PricelistRow, self.model.code == PricelistRow.item_code)
            .filter(
                and_(
                    self.model.is_active.is_(True),
                    PricelistRow.pricelist_code == branch_obj.pricelist_code,
                )
            )
            .order_by(self.model.code)
            .all()
        )
        if not items_obj:
            raise HTTPException(
                status_code=404,
                detail=f"{branch_code.capitalize()} has no pricelist assign.",
            )
        return items_obj

    def bulkInsert(
        self,
        *,
        schemas: List[ItemCreate],
        curr_user: SystemUserCreate,
    ):
        list_object_dict = []

        for i in schemas:
            schema_dict = i.dict()
            schema_dict["created_by"] = curr_user.id
            list_object_dict.append(schema_dict)

        db.session.bulk_insert_mappings(self.model, list_object_dict)
        db.session.commit()
        return "Uploaded succesfully."

    def update(
        self,
        fk: str,
        *,
        update_schema: Union[ItemUpdate, Dict[str, Any]],
    ) -> Any:

        # Get the object first
        db_obj = self.get(fk=fk)

        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid item code."
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_item = CRUDItem(Item)
