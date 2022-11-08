from datetime import datetime

from typing import List, Optional
from sqlmodel import Field, SQLModel


class InvAdjustmentInHeaderBase(SQLModel):
    transdate: Optional[datetime] = Field(default=datetime.now())
    remarks: Optional[str] = Field(default=None)
    branch: Optional[str] = Field(
        foreign_key="branch.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    hashed_id: str = Field(sa_column_kwargs={"unique": True}, index=True)


class InvAdjustmentInHeaderCreate(InvAdjustmentInHeaderBase):
    pass


class InvAdjustmentInHeaderRead(
    InvAdjustmentInHeaderBase,
):
    id: int
    reference: str
    docstatus: str
    objtype: int
    rows: List["InvAdjustmentInRowRead"]
    created_by_user: Optional["SystemUserRead"]
    updated_by_user: Optional["SystemUserRead"]
    date_created: datetime
    date_updatedd: Optional["datetime"]


class InvAdjustmentInHeaderUpdate(InvAdjustmentInHeaderBase):
    pass


class InvAdjustmentInHeaderCancel(SQLModel):
    canceled_remarks: str


from .schemas_row import InvAdjustmentInRowRead
from ...MasterData.system_user.schemas import SystemUserRead

InvAdjustmentInHeaderRead.update_forward_refs()
