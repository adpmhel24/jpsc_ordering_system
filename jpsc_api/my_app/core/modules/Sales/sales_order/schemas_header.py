from datetime import datetime
from decimal import Decimal
from typing import List, Optional
from sqlmodel import SQLModel, Field
from pydantic import condecimal, confloat

from my_app.shared.custom_enums.custom_enums import DocstatusEnum, OrderStatusEnum

from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
    UpdatedBase,
    CanceledBase,
)


class SalesOrderHeaderBase(SQLModel):
    transdate: Optional[datetime] = Field(default=datetime.now())
    customer_code: str = Field(
        foreign_key="customer.code",
        index=True,
        fk_kwargs={"onupdate": "CASCADE"},
    )
    delivery_date: datetime = Field(default=datetime.now())
    delivery_method: Optional[str] = Field(index=True)
    payment_term: Optional[str] = Field(
        index=True, foreign_key="payment_term.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    remarks: Optional[str]
    dispatching_branch: str = Field(
        index=True, foreign_key="branch.code", fk_kwargs={"onudpate": "CASCADE"}
    )
    hashed_id: str = Field(sa_column_kwargs={"unique": True})
    contact_number: Optional[str]
    address: Optional[str]
    customer_notes: Optional[str]


class SalesOrderHeaderAddCol(SQLModel):
    reference: Optional[str] = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(default=DocstatusEnum.open, index=True)
    order_status: int = Field(
        default=OrderStatusEnum.for_price_confirmation, index=True
    )
    date_dispatched: Optional[datetime]
    payment_reference: Optional[str]
    subtotal: condecimal(max_digits=20, decimal_places=2) = Field(default=Decimal(0.00))
    gross: condecimal(max_digits=20, decimal_places=2) = Field(default=Decimal(0.00))
    delfee: condecimal(max_digits=20, decimal_places=2) = Field(default=Decimal(0.00))
    otherfee: condecimal(max_digits=20, decimal_places=2) = Field(default=Decimal(0.00))
    confirmed_by: Optional[int] = Field(foreign_key="system_user.id")
    date_confirmed: Optional[datetime]
    dispatched_by: Optional[int] = Field(foreign_key="system_user.id")

    # rows
    # comments
    # attachments


class SalesOrderHeaderCreate(SalesOrderHeaderBase):
    pass


class SalesOrderHeaderRead(
    CanceledBase,
    CreatedBase,
    UpdatedBase,
    SalesOrderHeaderAddCol,
    SalesOrderHeaderBase,
    PrimaryKeyBase,
):
    rows: List["SalesOrderRowRead"]
    created_by_user: Optional["SystemUserRead"]
    updated_by_user: Optional["SystemUserRead"]
    canceled_by_user: Optional["SystemUserRead"]
    confirmed_by_user: Optional["SystemUserRead"]
    dispatched_by_user: Optional["SystemUserRead"]


class SalesOrderHeaderUpdate(
    CanceledBase,
    CreatedBase,
    UpdatedBase,
    SalesOrderHeaderAddCol,
    SalesOrderHeaderBase,
    PrimaryKeyBase,
):
    rows: List["SalesOrderRowRead"]


from .schemas_row import SalesOrderRowRead
from ...MasterData.system_user.schemas import SystemUserRead

SalesOrderHeaderRead.update_forward_refs()
SalesOrderHeaderUpdate.update_forward_refs()
