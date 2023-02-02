from typing import Any, Dict, List, Optional
from sqlmodel import or_, func, and_

from fastapi_sqlalchemy import db
from my_app.shared.crud import CRUDBase
from .models import ObjectType
from .schemas import ObjectTypeCreate, ObjectTypeUpdate, ObjectTypeRead


class CRUDObjectType(
    CRUDBase[ObjectType, ObjectTypeCreate, ObjectTypeUpdate, ObjectTypeRead]
):
    def create(
        self,
        *,
        create_schema: ObjectTypeCreate,
        user_id: int,
    ) -> Any:
        c_dict = create_schema.dict()

        db_obj = ObjectType(**c_dict)

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj

    def get_all(
        self,
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
            .order_by(self.model.id)
            .all()
        )
        return db_obj


crud_objtype = CRUDObjectType(ObjectType)
