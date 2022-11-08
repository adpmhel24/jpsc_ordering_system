from typing import Optional
from sqlmodel import SQLModel, Field
from pydantic import condecimal


class CustomerAddressBase(SQLModel):

    customer_code: str = Field(
        foreign_key="customer.code",
        fk_kwargs={"onupdate": "CASCADE", "ondelete": "RESTRICT"},
        index=True,
    )
    street_address: str = Field(index=True)
    brgy: str = Field(index=True)
    city_municipality: str = Field(index=True)
    other_details: Optional[str]
    contact_number: Optional[str]
    is_default: Optional[bool] = Field(default=True)
    delivery_fee: condecimal(max_digits=20, decimal_places=2)


class CustomerAddressRead(CustomerAddressBase):
    pass


class CustomerAddressUpdate(CustomerAddressBase):
    pass
