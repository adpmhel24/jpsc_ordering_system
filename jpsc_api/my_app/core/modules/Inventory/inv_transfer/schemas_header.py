from .schemas_row import InvTrfrRowRead
from datetime import datetime
from typing import List, Optional
from sqlmodel import SQLModel, Field

from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase


class InvTrfrHeaderBase(SQLModel):
    transdate: datetime = Field(default=datetime.now())
    remarks: Optional[str]
    hashed_id: str = Field(sa_column_kwargs={"unique": True})


class InvTrfrHeaderCreate(InvTrfrHeaderBase):
    pass


class InvTrfrHeaderRead(UpdatedBase, CreatedBase, InvTrfrHeaderBase, PrimaryKeyBase):
    docstatus: str
    objtype: int
    rows: List["InvTrfrRowRead"]


class InvTrfrHeaderUpdate(InvTrfrHeaderBase):
    pass


InvTrfrHeaderRead.update_forward_refs()
