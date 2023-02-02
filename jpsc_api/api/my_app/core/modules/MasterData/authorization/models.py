from typing import TYPE_CHECKING, Optional
from sqlmodel import Relationship
from sqlalchemy.orm import relationship

from my_app.shared.schemas.base_schemas import PrimaryKeyBase, UpdatedBase
from .base_model import AuthorizationBase

if TYPE_CHECKING:
    from ..system_user.models import SystemUser
    from ..object_type.models import ObjectType


class Authorization(UpdatedBase, AuthorizationBase, PrimaryKeyBase, table=True):
    __tablename__ = "sys_auth"

    system_user: "SystemUser" = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="Authorization.system_user_id == SystemUser.id",
            viewonly=True,
        )
    )

    object_type_obj: Optional["ObjectType"] = Relationship(
        sa_relationship=relationship(
            "ObjectType",
            primaryjoin="and_(ObjectType.id == Authorization.objtype, ObjectType.is_active)",
            viewonly=True,
        )
    )
