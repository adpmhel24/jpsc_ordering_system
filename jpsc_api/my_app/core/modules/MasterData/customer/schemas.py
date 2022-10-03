from typing import List
from .models import CustomerOtherColumn, CustomerBase
from my_app.shared.schemas.base_schemas import (
    CreatedBase,
    UpdatedBase,
)


class CustomerCreate(CustomerBase):
    pass


class CustomerUpdate(UpdatedBase, CreatedBase, CustomerOtherColumn, CustomerBase):
    pass


class CustomerRead(UpdatedBase, CreatedBase, CustomerOtherColumn, CustomerBase):
    addresses: List["CustomerAddressRead"]


from ..customer_address.schemas import CustomerAddressRead

CustomerRead.update_forward_refs()
