from typing import List, Optional

from sqlmodel import Field
from .models import CustomerOtherColumn, CustomerBase
from my_app.shared.schemas.base_schemas import (
    CreatedBase,
    UpdatedBase,
)


class CustomerCreate(CustomerBase):
    pass


class CustomerUpdate(CustomerBase):
    addresses: List["CustomerAddressRead"]


class CustomerRead(UpdatedBase, CreatedBase, CustomerOtherColumn, CustomerBase):
    is_active: Optional[bool]
    is_approved: Optional[bool]
    addresses: List["CustomerAddressRead"]


from ..customer_address.schemas import CustomerAddressRead

CustomerRead.update_forward_refs()
