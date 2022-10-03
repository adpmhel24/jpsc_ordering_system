from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional, Union
from sqlmodel import or_, func, and_
from fastapi_sqlalchemy import db
from my_app.shared.crud import CRUDBase

from .models import Customer
from .schemas import CustomerCreate, CustomerUpdate, CustomerRead
from ..customer_address import CustomerAddress, CustomerAddressCreate


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
        db_obj.full_name = f"{customer_schema.first_name.capitalize()} {customer_schema.last_name.capitalize()}"

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
                )
            )
            .order_by(self.model.code)
        )
        return db_obj

    def get_by_branch(
        self,
        *,
        is_active: Optional[bool],
        is_approved: Optional[bool],
        branchCode: str,
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    self.model.is_active.is_(True),
                    self.model.location == branchCode,
                    or_(
                        not is_active,
                        self.model.is_active.is_(is_active),
                    ),
                    or_(
                        not is_approved,
                        self.model.is_approved.is_(is_approved),
                    ),
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
        update_schema: Union[CustomerUpdate, Dict[str, Any]],
    ) -> Any:
        db_obj = self.get(fk=fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid Customer Code."
            )
        existing_obj = (
            db.session.query(self.model)
            .filter(
                and_(
                    func.lower(self.model.code) == update_schema.code.lower(),
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
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_customer = CRUDCustomer(Customer)
