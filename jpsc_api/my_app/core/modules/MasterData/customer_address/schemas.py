from .models import CustomerAddressBase, CustomerAddress


class CustomerAddressCreate(CustomerAddressBase):
    pass


class CustomerAddressRead(CustomerAddress):
    pass


class CustomerAddressUpdate(CustomerAddressBase):
    pass
