from fastapi import HTTPException, status
from typing import Any, Dict, Union
from sqlmodel import func
from fastapi_sqlalchemy import db

from my_app.shared.crud import CRUDBase
from .models import UoM
from .schemas import UoMCreate, UoMRead, UoMUpdate


class CRUDUoM(CRUDBase[UoM, UoMCreate, UoMUpdate, UoMRead]):
    def create(
        self,
        *,
        create_schema: UoMCreate,
        user_id: int,
    ) -> Any:

        # Check if uom code was passed is already exist
        uom_obj = (
            db.session.query(self.model)
            .filter(func.lower(self.model.code) == create_schema.code.lower())
            .first()
        )
        if uom_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="UoM code already exist.",
            )

        # create schema model to dict
        c_dict = create_schema.dict()

        db_obj = self.model(**c_dict)
        db_obj.created_by = user_id

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj

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
        update_schema: Union[UoMUpdate, Dict[str, Any]],
    ) -> Any:

        # Get the obj.
        db_obj = self.get(fk=fk)

        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid uom code."
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_uom = CRUDUoM(UoM)
