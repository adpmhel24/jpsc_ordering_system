from datetime import datetime
from decimal import Decimal
from typing import List, Optional
from sqlmodel import SQLModel, Field
from pydantic import condecimal, confloat

from my_app.shared.custom_enums.custom_enums import DocstatusEnum, PQStatusEnum

from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
    UpdatedBase,
    CanceledBase,
    ApprovedBase,
)


class PriceQuotationHeaderBase(SQLModel):
    transdate: Optional[datetime] = Field(default=datetime.now())
    customer_code: str = Field(
        foreign_key="customer.code",
        index=True,
        fk_kwargs={"onupdate": "CASCADE", "ondelete": "RESTRICT"},
    )
    delivery_date: datetime = Field(default=datetime.now())
    delivery_method: Optional[str] = Field(index=True)
    payment_terms: Optional[str] = Field(
        index=True, foreign_key="payment_terms.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    remarks: Optional[str]
    dispatching_branch: str = Field(
        index=True, foreign_key="branch.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    hashed_id: str = Field(sa_column_kwargs={"unique": True})
    contact_number: Optional[str]
    address: Optional[str]
    customer_notes: Optional[str]


class PriceQuotationHeaderAddCol(SQLModel):
    reference: Optional[str] = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(default=DocstatusEnum.open, index=True)
    pq_status: int = Field(default=PQStatusEnum.for_price_confirmation, index=True)
    sq_number: Optional[int] = Field(index=True)
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


class PriceQuotationHeaderCreate(PriceQuotationHeaderBase):
    pass


class PriceQuotationHeaderRead(
    CanceledBase,
    ApprovedBase,
    CreatedBase,
    UpdatedBase,
    PriceQuotationHeaderAddCol,
    PriceQuotationHeaderBase,
    PrimaryKeyBase,
):
    rows: List["PriceQuotationRowRead"]
    created_by_user: Optional["SystemUserTransacted"]
    updated_by_user: Optional["SystemUserTransacted"]
    approved_by_user: Optional["SystemUserTransacted"]
    canceled_by_user: Optional["SystemUserTransacted"]
    confirmed_by_user: Optional["SystemUserTransacted"]
    dispatched_by_user: Optional["SystemUserTransacted"]


class PriceQuotationHeaderUpdate(
    CanceledBase,
    CreatedBase,
    UpdatedBase,
    PriceQuotationHeaderAddCol,
    PriceQuotationHeaderBase,
    PrimaryKeyBase,
):
    rows: List["PriceQuotationRowRead"]


from .schemas_row import PriceQuotationRowRead
from ...MasterData.system_user.schemas import SystemUserTransacted

PriceQuotationHeaderRead.update_forward_refs()
PriceQuotationHeaderUpdate.update_forward_refs()
