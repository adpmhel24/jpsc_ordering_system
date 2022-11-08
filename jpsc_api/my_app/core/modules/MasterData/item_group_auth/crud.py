from datetime import datetime
from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional, Union
from sqlmodel import or_, func, and_

from fastapi_sqlalchemy import db
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.shared.crud import CRUDBase
from .models import ItemGroupUserAuth
from .schemas import (
    ItemGroupUserAuthCreate,
    ItemGroupUserAuthRead,
    ItemGroupUserAuthUpdate,
)
from fastapi.encoders import jsonable_encoder


class CRUDItemGroupUserAuth(
    CRUDBase[
        ItemGroupUserAuth,
        ItemGroupUserAuthCreate,
        ItemGroupUserAuthRead,
        ItemGroupUserAuthUpdate,
    ]
):
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


crud_item_group_auth = CRUDItemGroupUserAuth(ItemGroupUserAuth)
