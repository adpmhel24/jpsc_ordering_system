from typing import TYPE_CHECKING

from typing import Optional
from sqlmodel import SQLModel, Field, Relationship
from pydantic import condecimal
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase, PrimaryKeyBase


if TYPE_CHECKING:
    from ..customer.models import Customer


class CustomerAddressBase(SQLModel):

    province: Optional[str] = Field(index=True)
    city_municipality: Optional[str] = Field(index=True)
    street_address: Optional[str] = Field(index=True)
    brgy: Optional[str] = Field(index=True)
    is_default: Optional[bool] = Field(default=True)
    other_details: Optional[str] = Field(index=True)


class CustomerOtherField(SQLModel):
    customer_code: str = Field(
        foreign_key="customer.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )


class CustomerAddress(
    UpdatedBase,
    CreatedBase,
    CustomerOtherField,
    CustomerAddressBase,
    PrimaryKeyBase,
    table=True,
):
    __tablename__ = "customer_address"

    customer: "Customer" = Relationship(back_populates="addresses")
