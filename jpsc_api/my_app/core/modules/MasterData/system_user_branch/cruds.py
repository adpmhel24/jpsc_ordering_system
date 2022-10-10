from typing import Any, Dict, List
from fastapi import HTTPException, status
from sqlalchemy import select
from sqlmodel import and_, func
from pydantic import EmailStr
from fastapi_sqlalchemy import db


from my_app.shared.crud import CRUDBase
from ..system_user.models import SystemUser
from .schemas import (
    SystemUserBranchCreate,
    SystemUserBranchUpdate,
    SystemUserBranchRead,
)
from .models import SystemUserBranch


class CRUDSystemBranch(
    CRUDBase[
        SystemUserBranch,
        SystemUserBranchCreate,
        SystemUserBranchUpdate,
        SystemUserBranchRead,
    ]
):
    def create(
        self,
        schema: SystemUserBranchCreate,
    ) -> SystemUserBranchRead:

        system_user_obj = db.session.query(SystemUser).get(schema.system_user_id)

        # Check if valid system user id
        # then raise Exception.
        if not system_user_obj:
            raise HTTPException(status_code=404, detail="Invalid system user id.")

        sys_user_branch_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    self.model.branch_code == schema.branch_code,
                    self.model.system_user_id == schema.system_user_id,
                )
            )
            .first()
        )
        if sys_user_branch_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST, detail="Existing already."
            )

        obj = self.model(**schema.dict())
        db.session.add(obj)
        db.session.commit()
        db.session.refresh()

        return obj

    def get_assigned_branch(
        self,
        system_user_id: int,
    ) -> List[SystemUserBranchRead]:
        obj = (
            db.session.query(self.model)
            .filter(self.model.system_user_id == system_user_id)
            .order_by(
                self.model.is_assigned.is_(True),
            )
            .all()
        )
        if not obj:
            raise HTTPException(status_code=404, detail="Invalid system user id.")
        return obj

    def get_assigned_branch_by_email(
        self,
        email: EmailStr,
    ) -> List[SystemUserBranchRead]:
        system_user_obj = (
            db.session.query(SystemUser).filter(SystemUser.email == email).first()
        )
        obj = (
            db.session.query(self.model)
            .filter(
                self.model.system_user_id == system_user_obj.id,
                self.model.is_assigned.is_(True),
            )
            .order_by(
                self.model.is_assigned.is_(True),
            )
            .all()
        )

        return obj

    def update_assigned_branch(
        self,
        *,
        obj_in: List[SystemUserBranchUpdate],
    ) -> None:

        list_object_dict = [i.dict() for i in obj_in]
        db.session.bulk_update_mappings(SystemUserBranch, list_object_dict)
        db.session.commit()
        return "Updated successfully."


crud_sys_user_branch = CRUDSystemBranch(SystemUserBranch)
