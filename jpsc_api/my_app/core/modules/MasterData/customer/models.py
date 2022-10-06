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
    code: str = Field(primary_key=True, index=True, sa_column_kwargs={"unique": True})

    first_name: Optional[str] = Field(index=True)
    last_name: Optional[str] = Field(index=True)
    contact_number: Optional[str]
    email: Optional[EmailStr]
    location: str = Field(
        foreign_key="branch.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )

    payment_term: Optional[str] = Field(
        foreign_key="payment_term.code", fk_kwargs={"onupdate": "CASCADE"}
    )
    credit_limit: condecimal(max_digits=20, decimal_places=2) = Field(default=0)


class CustomerOtherColumn(SQLModel):
    full_name: Optional[str] = Field(index=True)
    is_active: bool = Field(
        default=True, sa_column_kwargs={"server_default": text("true")}
    )
    is_approved: bool = Field(sa_column_kwargs={"server_default": text("false")})


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


# class CustomerAttachment(UpdatedBase, CreatedBase, table=True):
#     pass
