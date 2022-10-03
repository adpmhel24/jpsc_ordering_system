from .schemas_row import InvTrfrReqRowRead
from datetime import datetime
from typing import List, Optional
from sqlmodel import SQLModel, Field
from my_app.shared.schemas.base_schemas import CreatedBase, PrimaryKeyBase, UpdatedBase


class InvTrfrReqHeaderBase(SQLModel):
    transdate: datetime = Field(default=datetime.now())
    remarks: Optional[str] = Field(default=None)
    branch: Optional[str] = Field(
        foreign_key="branch.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    hashed_id: str = Field(sa_column_kwargs={"unique": True}, index=True)


class InvTrfrReqHeaderCreate(InvTrfrReqHeaderBase):
    pass


class InvTrfrReqHeaderRead(InvTrfrReqHeaderBase):
    id: int
    reference: str
    docstatus: str
    objtype: int
    rows: List["InvTrfrReqRowRead"]
    created_by_user: Optional["SystemUserRead"]
    updated_by_user: Optional["SystemUserRead"]
    date_created: datetime
    date_udpated: Optional["datetime"]


class InvTrfrReqHeaderUpdate(InvTrfrReqHeaderBase):
    pass


from ...MasterData.system_user.schemas import SystemUserRead

InvTrfrReqHeaderRead.update_forward_refs()
