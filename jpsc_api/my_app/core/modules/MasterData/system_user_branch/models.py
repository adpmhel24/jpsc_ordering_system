from typing import TYPE_CHECKING
from sqlmodel import Field, Column, BOOLEAN, Relationship, text, INTEGER

from sqlalchemy.orm import relationship
from .schemas import SystemUserBranchBase

if TYPE_CHECKING:
    from ..system_user.models import SystemUser


class SystemUserBranch(SystemUserBranchBase, table=True):
    __tablename__ = "system_user_branch"

    id: int = Field(
        sa_column=Column(
            INTEGER,
            autoincrement=True,
            primary_key=True,
        )
    )
    is_assigned = Field(
        default=False, sa_column=Column(BOOLEAN, server_default=text("false"))
    )

    # system_user: "SystemUser" = Relationship(
    #     sa_relationship=relationship(
    #         "SystemUser",
    #     )
    # )
