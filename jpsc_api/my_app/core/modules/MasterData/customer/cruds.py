from datetime import datetime
from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional
from sqlmodel import or_, func, and_
from fastapi_sqlalchemy import db
from my_app.shared.crud import CRUDBase
from fastapi.encoders import jsonable_encoder


from .models import Customer
from .schemas import CustomerCreate, CustomerUpdate, CustomerRead
from ..customer_address import CustomerAddress, CustomerAddressCreate
from ..system_user.models import SystemUser


class CRUDCustomer(CRUDBase[Customer, CustomerCreate, CustomerUpdate, CustomerRead]):
    def create(
        self,
        *,
        customer_schema: CustomerCreate,
        addresses_schema: Optional[List[CustomerAddressCreate]],
        user_id: int,
    ) -> Any:

        # Check if branch code was passed is already exist
        customer_obj = (
            db.session.query(self.model)
            .filter(func.lower(self.model.code) == customer_schema.code.lower())
            .first()
        )
        if customer_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Customer code already exist.",
            )

        db_obj: Customer = Customer(**customer_schema.dict())
        db_obj.created_by = user_id

        if addresses_schema:
            for address_schema in addresses_schema:
                address_obj = CustomerAddress(**address_schema.dict())
                address_obj.created_by = user_id
                db_obj.addresses.append(address_obj)

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj

    def get_all(
        self,
        *,
        is_active: Optional[bool],
        is_approved: Optional[bool],
        with_sap: Optional[bool],
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    or_(
                        is_active == None,
                        self.model.is_active.is_(is_active),
                    ),
                    or_(
                        is_approved == None,
                        self.model.is_approved.is_(is_approved),
                    ),
                    or_(
                        with_sap == None,
                        self.model.with_sap.is_(with_sap),
                    ),
                )
            )
            .order_by(self.model.code)
        )
        return db_obj

    def bulkInsert(
        self,
        *,
        schemas: List[CustomerCreate],
        curr_user: SystemUser,
    ):
        list_object_dict = []

        for i in schemas:
            exist_data = db.session.query(self.model).filter_by(code=i.code).first()
            if not exist_data:
                schema_dict = i.dict()
                schema_dict["created_by"] = curr_user.id
                list_object_dict.append(schema_dict)

        db.session.bulk_insert_mappings(self.model, list_object_dict)
        db.session.commit()
        return "Uploaded succesfully."

    def get_by_branch(
        self,
        *,
        is_active: Optional[bool],
        is_approved: Optional[bool],
        with_sap: Optional[bool],
        branchCode: str,
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    self.model.location == branchCode,
                    self.model.is_active.is_(is_active),
                    self.model.is_approved.is_(is_approved),
                    self.model.with_sap.is_(with_sap),
                )
            )
            .order_by(self.model.code)
            .all()
        )
        return db_obj

    def update(
        self,
        fk: str,
        *,
        update_dict_data: Dict[str, Any],
        user_id: int,
    ) -> Any:
        cust_db_obj = self.get(fk=fk)
        if not cust_db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid Customer Code."
            )

        cust_dict_data = update_dict_data.pop("customer_schema")
        cust_addresses_dict_data = update_dict_data.pop("addresses_schema")

        # Get the schema code and check if the code is existing
        existing_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    func.lower(self.model.code) == cust_dict_data["code"].lower(),
                    self.model.code != fk,
                )
            )
            .first()
        )
        if existing_obj:
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="Customer code Already exist.",
            )
        cust_obj_data = jsonable_encoder(cust_db_obj)

        # update customer
        for field in cust_obj_data:
            if field in cust_dict_data:
                setattr(cust_db_obj, field, cust_dict_data[field])

        for address_dict in cust_addresses_dict_data:
            if address_dict["id"]:
                cust_address_db_obj = db.session.query(CustomerAddress).get(
                    address_dict["id"]
                )
                if address_dict["isRemove"]:
                    db.session.delete(cust_address_db_obj)
                else:
                    cust_add_obj_data = jsonable_encoder(cust_address_db_obj)
                    for field in cust_add_obj_data:
                        if field in address_dict:
                            setattr(cust_address_db_obj, field, address_dict[field])
                    cust_address_db_obj.updated_by = user_id
                    cust_address_db_obj.date_updated = datetime.now()
            else:
                address_obj = CustomerAddress(**address_dict)
                address_obj.created_by = user_id
                cust_db_obj.addresses.append(address_obj)

        cust_db_obj.updated_by = user_id
        cust_db_obj.date_updated = datetime.now()

        db.session.add(cust_db_obj)
        db.session.commit()
        db.session.refresh(cust_db_obj)
        return cust_db_obj


crud_customer = CRUDCustomer(Customer)
