from datetime import datetime

from typing import TYPE_CHECKING, List, Optional
from sqlmodel import Field, SQLModel

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase

# if TYPE_CHECKING:
#     from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead


class InvAdjustmentOutHeaderBase(SQLModel):
    transdate: Optional[datetime] = Field(default=datetime.now())
    remarks: Optional[str] = Field(default=None)
    branch: Optional[str] = Field(
        foreign_key="branch.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    hashed_id: str = Field(sa_column_kwargs={"unique": True}, index=True)


class InvAdjustmentOutHeaderCreate(InvAdjustmentOutHeaderBase):
    pass


class InvAdjustmentOutHeaderRead(
    UpdatedBase,
    CreatedBase,
    InvAdjustmentOutHeaderBase,
):
    id: int
    docstatus: str
    reference: str
    docstatus: str
    rows: List["InvAdjustmentOutRowRead"]
    created_by_user: Optional["SystemUserRead"]
    updated_by_user: Optional["SystemUserRead"]
    date_created: datetime
    date_updatedd: Optional["datetime"]


class InvAdjustmentOutHeaderUpdate(InvAdjustmentOutHeaderBase):
    pass


class InvAdjustmentOutHeaderCancel(SQLModel):
    canceled_remarks: str


from my_app.core.modules.Inventory.inv_adjustment_out.schemas_row import (
    InvAdjustmentOutRowRead,
)

from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead

InvAdjustmentOutHeaderRead.update_forward_refs()
