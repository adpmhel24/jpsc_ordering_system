from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional, Union
from sqlmodel import or_, func, and_
from fastapi_sqlalchemy import db
from my_app.shared.crud import CRUDBase
from .models import Position
from .schemas import PositionCreate, PositionRead, PositionUpdate


class CRUDPosition(CRUDBase[Position, PositionCreate, PositionRead, PositionUpdate]):
    def create(
        self,
        *,
        create_schema: PositionCreate,
        user_id: int,
    ) -> Any:

        # Check if new position code is already exist
        position_obj = (
            db.session.query(self.model)
            .filter(func.lower(self.model.code) == create_schema.code.lower())
            .first()
        )
        if position_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Position code already exist.",
            )
        # create schema model to dict
        c_dict = create_schema.dict()

        db_obj = Position(**c_dict)
        db_obj.created_by = user_id

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj

    def get_all(
        self,
    ) -> Any:
        db_obj = db.session.query(self.model).order_by(self.model.code).all()
        return db_obj

    def update(
        self,
        fk: str,
        *,
        update_schema: Union[PositionRead, Dict[str, Any]],
    ) -> Any:
        db_obj = self.get(fk=fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid position code."
            )
        existing_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    func.lower(self.model.code) == update_schema.code.lower(),
                )
            )
            .first()
        )
        if existing_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Position code Already exist.",
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_position = CRUDPosition(Position)
