from typing import TYPE_CHECKING, List
from sqlalchemy.orm import relationship
from sqlmodel import Relationship
from my_app.shared.schemas.base_schemas import PrimaryKeyBase
from .schemas import DbAdditionalField, SystemUserBase
from sqlalchemy_events import listen_events, on

if TYPE_CHECKING:
    from ..system_user_branch.models import SystemUserBranch


@listen_events
class SystemUser(DbAdditionalField, SystemUserBase, PrimaryKeyBase, table=True):
    """System User Database Model"""

    __tablename__ = "system_user"

    assigned_branch: List["SystemUserBranch"] = Relationship(
        sa_relationship=relationship(
            "SystemUserBranch", lazy=True, order_by="SystemUserBranch.branch_code"
        ),
    )

    @on("before_insert")
    def lowercase_email(mapper, conn, self):
        self.email = self.email.lower()
