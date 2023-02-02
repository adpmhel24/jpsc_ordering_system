from datetime import datetime
from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional, Union
from sqlmodel import or_, func, and_

from fastapi_sqlalchemy import db
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.shared.crud import CRUDBase
from .models import Authorization
from .schemas import AuthorizationCreate, AuthorizationRead, AuthorizationUpdate
from fastapi.encoders import jsonable_encoder


class CRUDAuthorization(
    CRUDBase[Authorization, AuthorizationCreate, AuthorizationRead, AuthorizationUpdate]
):
    def create(
        self,
        *,
        create_schema: AuthorizationCreate,
        user_id: int,
    ) -> Any:
        c_dict = create_schema.dict()

        db_obj = Authorization(**c_dict)
        db_obj.created_by = user_id

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj

    def get_all(
        self,
    ) -> Any:
        db_obj = db.session.query(self.model).order_by(self.model.id).all()
        return db_obj

    def bulk_update(
        self,
        lists_to_update_dict: List[dict],
        curr_user: SystemUserRead,
    ):
        for to_update_dict in lists_to_update_dict:
            auth_obj = db.session.query(self.model).get(to_update_dict["id"])
            auth_obj_data = jsonable_encoder(auth_obj)
            for field in auth_obj_data:
                if field in to_update_dict and to_update_dict[field] != getattr(
                    auth_obj, field
                ):
                    setattr(auth_obj, field, to_update_dict[field])
                    auth_obj.updated_by = curr_user.id
                    auth_obj.date_updated = datetime.now()

        db.session.commit()
        return "Updated successfully."

    def update(
        self,
        fk: str,
        *,
        update_schema: Union[AuthorizationRead, Dict[str, Any]],
    ) -> Any:
        db_obj = self.get(fk=fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid branch code."
            )
        existing_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    func.lower(self.model.code) == update_schema.code.lower(),
                    self.model.code != fk,
                )
            )
            .first()
        )
        if existing_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Authorization code Already exist.",
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_auth = CRUDAuthorization(Authorization)
