from typing import TYPE_CHECKING, List, Optional
from pydantic import EmailStr


from sqlmodel import Column, SQLModel, Field, text, BOOLEAN

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase, PrimaryKeyBase
from datetime import datetime

if TYPE_CHECKING:
    from ..system_user_branch.models import SystemUserBranch


class SystemUserBase(SQLModel):

    email: EmailStr = Field(index=True, sa_column_kwargs={"unique": True})
    first_name: Optional[str] = Field(index=True)
    last_name: Optional[str] = Field(index=True)
    is_super_admin: bool = Field(
        default=False, sa_column=Column(BOOLEAN, server_default=text("false"))
    )
    is_active: Optional[bool] = Field(
        sa_column=Column(BOOLEAN, server_default=text("true"))
    )
    position_code: Optional[str] = Field(
        foreign_key="position.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )


class DbAdditionalField(UpdatedBase, CreatedBase, SQLModel):
    """Additional Field for Db"""

    is_active: Optional[bool] = Field(
        sa_column=Column(BOOLEAN, server_default=text("true"))
    )
    hashed_password: str
    last_login: Optional[datetime] = Field(default=None)


class SystemUserCreate(SystemUserBase):
    """Create Schema"""

    password: str


class SystemUserUpdate(SystemUserBase):
    password: Optional[str]


class SystemUserRead(SystemUserBase, PrimaryKeyBase):
    """Read Schema"""

    is_active: Optional[bool]
    assigned_branch: Optional[List["SystemUserBranch"]]
    authorizations: Optional[List["AuthorizationRead"]]
    item_group_auth: Optional[List["ItemGroupUserAuthRead"]]


from ..authorization.schemas import AuthorizationRead
from ..system_user_branch.models import SystemUserBranch
from ..item_group_auth.schemas import ItemGroupUserAuthRead

SystemUserRead.update_forward_refs()
