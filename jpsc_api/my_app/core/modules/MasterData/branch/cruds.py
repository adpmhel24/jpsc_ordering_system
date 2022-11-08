from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional, Union
from sqlmodel import or_, func, and_

from fastapi_sqlalchemy import db
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.dependencies import get_authorized_user
from my_app.shared.crud import CRUDBase
from my_app.shared.custom_enums.enum_object_types import ObjectTypesEnum
from . import Branch
from .schemas import BranchCreate, BranchUpdate, BranchRead


class CRUDBranch(CRUDBase[Branch, BranchCreate, BranchUpdate, BranchRead]):
    def create(
        self,
        *,
        create_schema: BranchCreate,
        current_user: SystemUserRead,
    ) -> Any:
        get_authorized_user(
            objtype=ObjectTypesEnum.branch_data,
            current_user=current_user,
            full=True,
            create=True,
        )
        c_dict = create_schema.dict()

        db_obj = Branch(**c_dict)
        db_obj.created_by = current_user.id

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj

    def get_all(
        self,
        *,
        is_active: Optional[bool],
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                or_(
                    not is_active,
                    self.model.is_active.is_(is_active),
                )
            )
            .order_by(self.model.code)
            .all()
        )
        return db_obj

    def update(
        self,
        *,
        fk: str,
        update_schema: Union[BranchUpdate, Dict[str, Any]],
        current_user: SystemUserRead,
    ) -> Any:
        get_authorized_user(
            objtype=ObjectTypesEnum.branch_data,
            current_user=current_user,
            full=True,
        )
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
                detail="Branch code Already exist.",
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_branch = CRUDBranch(Branch)
