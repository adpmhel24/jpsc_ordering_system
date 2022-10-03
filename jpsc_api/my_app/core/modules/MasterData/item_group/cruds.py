from fastapi import HTTPException, status
from typing import Any, Dict, Union
from sqlmodel import func
from sqlalchemy.exc import SQLAlchemyError
from fastapi_sqlalchemy import db

from my_app.shared.crud import CRUDBase
from .models import ItemGroup
from .schemas import ItemGroupCreate, ItemGroupRead, ItemGroupUpdate


class CRUDItemGroup(
    CRUDBase[
        ItemGroup,
        ItemGroupCreate,
        ItemGroupUpdate,
        ItemGroupRead,
    ]
):
    def create(
        self,
        *,
        create_schema: ItemGroupCreate,
        user_id: int,
    ) -> Any:
        try:
            # Check if item group code was passed is already exist
            item_grp_obj = (
                db.session.query(self.model)
                .filter(func.lower(self.model.code) == create_schema.code.lower())
                .first()
            )
            if item_grp_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Item group code already exist.",
                )

            # create schema model to dict
            c_dict = create_schema.dict()

            db_obj = self.model(**c_dict)
            db_obj.created_by = user_id

            db.session.add(db_obj)
            db.session.commit()
            db.session.refresh(db_obj)
            return db_obj

        except SQLAlchemyError as err:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=err)

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

    def update(
        self,
        fk: str,
        *,
        update_schema: Union[ItemGroupUpdate, Dict[str, Any]],
    ) -> Any:

        # Get the object first
        db_obj = self.get(fk=fk)

        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid item group code."
            )

        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_item_grp = CRUDItemGroup(ItemGroup)
