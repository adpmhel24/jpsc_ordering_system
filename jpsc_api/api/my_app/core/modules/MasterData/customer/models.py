from typing import TYPE_CHECKING, List, Optional
from sqlalchemy.orm import relationship
from sqlmodel import Relationship, SQLModel, Field, text
from my_app.shared.schemas.base_schemas import (
    CreatedBase,
    UpdatedBase,
)

from pydantic import condecimal, EmailStr


if TYPE_CHECKING:
    from ..customer_address.models import CustomerAddress


class CustomerBase(SQLModel):
    code: str = Field(
        primary_key=True, index=True, sa_column_kwargs={"unique": True}, max_length=15
    )
    card_name: Optional[str] = Field(index=True, max_length=100)
    first_name: Optional[str] = Field(index=True)
    middle_initial: Optional[str] = Field(index=True)
    last_name: Optional[str] = Field(index=True)
    contact_number: Optional[str] = Field(default=None)
    email: Optional[EmailStr] = Field(default=None)
    location: str = Field(
        foreign_key="branch.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )

    payment_terms: Optional[str] = Field(
        foreign_key="payment_terms.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    credit_limit: Optional[condecimal(max_digits=20, decimal_places=2)] = Field(
        default=0
    )


class CustomerOtherColumn(SQLModel):
    is_active: bool = Field(
        default=True, sa_column_kwargs={"server_default": text("true")}
    )
    is_approved: bool = Field(sa_column_kwargs={"server_default": text("false")})
    with_sap: bool = Field(sa_column_kwargs={"server_default": text("false")})


class Customer(UpdatedBase, CreatedBase, CustomerOtherColumn, CustomerBase, table=True):
    __tablename__ = "customer"

    addresses: List["CustomerAddress"] = Relationship(
        sa_relationship=relationship(
            "CustomerAddress",
            passive_deletes="all",
            passive_updates=False,
            back_populates="customer",
        )
    )
    created_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == Customer.created_by",
            lazy=True,
        )
    )


# class CustomerAttachment(UpdatedBase, CreatedBase, table=True):
#     pass
