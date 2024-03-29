from typing import Any, Dict, List, Optional, Union
from fastapi import HTTPException, status
from sqlalchemy import select
from sqlalchemy.exc import SQLAlchemyError
from sqlmodel import and_, or_
from fastapi_sqlalchemy import db

from my_app.core.settings import verify_password, get_password_hash

from my_app.shared.crud import CRUDBase
from .models import SystemUser
from .schemas import (
    SystemUserCreate,
    SystemUserRead,
    SystemUserUpdate,
)
from ..object_type.models import ObjectType
from ..authorization.models import Authorization


class CRUDUser(
    CRUDBase[
        SystemUser,
        SystemUserCreate,
        SystemUserUpdate,
        SystemUserRead,
    ]
):
    def get_by_email(self, *, email: str) -> Optional[SystemUser]:

        system_user = (
            db.session.query(self.model).filter(self.model.email == email).first()
        )
        return system_user

    def create(self, *, create_schema: SystemUserCreate) -> SystemUser:

        try:
            # Query email user if exist in the table then raise error if true
            sys_u_obj = (
                db.session.query(SystemUser)
                .filter(SystemUser.email == create_schema.email)
                .first()
            )
            if sys_u_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Email is already exist.",
                )

            create_schema.email = create_schema.email.strip().lower()
            # convert to dictionary
            obj_in_dict = create_schema.dict()
            hashed_password = get_password_hash(obj_in_dict.pop("password"))
            db_obj = SystemUser(**obj_in_dict)
            db_obj.hashed_password = hashed_password
            db.session.add(db_obj)
            db.session.commit()
            db.session.refresh(db_obj)
            return db_obj

        except SQLAlchemyError as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=e)

    def update(
        self,
        fk: int,
        *,
        obj_in: Union[SystemUserUpdate, Dict[str, Any]],
    ) -> SystemUser:
        db_obj = self.get(fk=fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="User id not found."
            )
        if isinstance(obj_in, dict):
            update_data = obj_in
        else:
            update_data = obj_in.dict(exclude_unset=True)
        if update_data["password"]:
            hashed_password = get_password_hash(update_data["password"])
            del update_data["password"]
            update_data["hashed_password"] = hashed_password
        return super().update(db_obj=db_obj, obj_in=update_data)

    def get_all_user(
        self,
        *,
        is_active: Optional[bool] = True,
    ) -> List[SystemUserRead]:

        db_obj = (
            db.session.query(SystemUser)
            .filter(
                and_(
                    or_(is_active == None, SystemUser.is_active.is_(is_active)),
                )
            )
            .order_by(SystemUser.id)
            .all()
        )
        return db_obj

    def bulkInsert(
        self,
        *,
        schemas: List[SystemUserCreate],
        curr_user: SystemUserRead,
    ):
        list_object_dict = []

        for i in schemas:
            schema_dict = i.dict()
            schema_dict["hashed_password"] = get_password_hash(
                schema_dict.pop("password")
            )
            schema_dict["created_by"] = curr_user.id
            list_object_dict.append(schema_dict)

        db.session.bulk_insert_mappings(self.model, list_object_dict)
        db.session.commit()
        return "Uploaded succesfully."

    def change_password(self, *, data_dict: dict, current_user: SystemUser):

        password = data_dict.pop("password")
        confirm_password = data_dict.pop("confirm_password")
        if not password or not confirm_password:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN, detail="Required fields!"
            )
        if password != confirm_password:
            raise HTTPException(
                status_code=status.HTTP_403_FORBIDDEN,
                detail="Confirm password doesn't match!",
            )

        system_user_obj = db.session.query(self.model).get(current_user.id)
        hashed_password = get_password_hash(password)
        system_user_obj.hashed_password = hashed_password
        db.session.commit()
        return "Updated successfully."

    def get_super_admin(self) -> Optional[SystemUser]:
        system_user = (
            db.session.query(SystemUser)
            .filter(SystemUser.is_super_admin.is_(True))
            .first()
        )
        return system_user

    def authenticate(self, *, email: str, password: str) -> Optional[SystemUser]:
        user = self.get_by_email(email=email)
        if not user:
            return None
        if not verify_password(password, user.hashed_password):
            return None
        return user

    def is_active(self, user: SystemUser) -> bool:
        return user.is_active

    def isSuperAdmin(self, user: SystemUser) -> bool:
        return user.is_super_admin


crud_sys_user = CRUDUser(SystemUser)
