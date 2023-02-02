from .schemas_row import InvReceiveRowRead
from datetime import datetime
from typing import TYPE_CHECKING, List, Optional
from sqlmodel import SQLModel, Field

from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase


class InvReceiveHeaderBase(SQLModel):
    transdate: datetime = Field(default=datetime.now())
    remarks: Optional[str]
    hashed_id: str


class InvReceiveHeaderCreate(InvReceiveHeaderBase):
    pass


class InvReceiveHeaderRead(
    UpdatedBase, CreatedBase, InvReceiveHeaderBase, PrimaryKeyBase
):
    docstatus: str
    objtype: int
    rows: List["InvReceiveRowRead"]


class InvReceiveHeaderUpdate(InvReceiveHeaderBase):
    pass


InvReceiveHeaderRead.update_forward_refs()
