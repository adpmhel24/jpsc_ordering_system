from typing import List
from sqlmodel import Field, SQLModel, Column, INTEGER, ForeignKey


class SystemUserBranchBase(SQLModel):
    system_user_id: int = Field(foreign_key="system_user.id", index=True)
    branch_code: str = Field(
        foreign_key="branch.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )


class SystemUserBranchCreate(SystemUserBranchBase):
    pass


class SystemUserBranchRead(SystemUserBranchBase):
    id: int
    is_assigned: bool


class SystemUserBranchUpdate(SystemUserBranchBase):
    id: int
    is_assigned: bool
