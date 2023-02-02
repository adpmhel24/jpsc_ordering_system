from datetime import datetime
from fastapi import HTTPException, status
from typing import Any

from fastapi_sqlalchemy import db

from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.shared.crud import CRUDBase
from ..customer.models import Customer
from .models import CustomerAddress
from .schemas import CustomerAddressCreate, CustomerAddressUpdate, CustomerAddressRead
from ..system_user.models import SystemUser


class CRUDCustomerAddress(
    CRUDBase[
        CustomerAddress,
        CustomerAddressCreate,
        CustomerAddressUpdate,
        CustomerAddressRead,
    ]
):
    def create(
        self,
        *,
        customer_code: str,
        schema: CustomerAddressCreate,
        current_user: SystemUserRead,
    ) -> Any:

        customer_obj: Customer = db.session.query(Customer).get(customer_code)
        # get the customer code.
        if not customer_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Invalid customer code",
            )

        if schema.is_default:
            existing_addresses_obj = (
                db.session.query(self.model)
                .filter(self.model.customer_code == customer_code)
                .all()
            )
            if existing_addresses_obj:
                for obj in existing_addresses_obj:
                    obj.is_default = False
                    db.session.add(obj)
        address_obj = CustomerAddress(**schema.dict())
        address_obj.created_by = current_user.id
        address_obj.date_created = datetime.now()
        customer_obj.addresses.append(address_obj)

        db.session.add(customer_obj)
        db.session.commit()
        db.session.refresh(address_obj)
        return address_obj

    def get_all(
        self,
    ) -> Any:
        db_obj = db.session.query(self.model).order_by(self.model.is_default.desc())
        return db_obj

    # def update_by_field(
    #     self,
    #     *,
    #     fk: str,
    #     update_dict_data: Dict[str, Any],
    #     current_user: SystemUserRead,
    # ) -> Any:
    #     cust_db_obj = self.get(fk=fk)
    #     if not cust_db_obj:
    #         raise HTTPException(
    #             status_code=status.HTTP_404_NOT_FOUND, detail="Invalid Customer Code."
    #         )

    #     cust_obj_data = jsonable_encoder(cust_db_obj)
    #     for field in cust_obj_data:
    #         if field in update_dict_data:
    #             if update_dict_data[field] != getattr(cust_db_obj, field):
    #                 setattr(cust_db_obj, field, update_dict_data[field])
    #                 cust_db_obj.updated_by = current_user.id
    #                 cust_db_obj.date_updated = datetime.now()

    #     db.session.add(cust_db_obj)
    #     db.session.commit()
    #     db.session.refresh(cust_db_obj)
    #     return cust_db_obj


crud_customer_address = CRUDCustomerAddress(CustomerAddress)
