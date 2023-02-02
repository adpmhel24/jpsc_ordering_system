from typing import List, Optional, Any, Dict
from fastapi import APIRouter, Depends, Query, status


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import CustomerCreate, CustomerRead, CustomerUpdate
from ..customer_address import CustomerAddressCreate
from .cruds import crud_customer
from ..system_user.schemas import SystemUserRead

from my_app.dependencies import (
    get_current_active_user,
)


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_customer(
    *,
    customer_schema: CustomerCreate,
    addresses_schema: Optional[List[CustomerAddressCreate]],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer.create(
        customer_schema=customer_schema,
        addresses_schema=addresses_schema,
        user_id=current_user.id,
    )
    return SuccessMessage(message="Successfully added!", data=result)


@router.post("/bulk_insert", response_model=SuccessMessage)
async def bulkInsert(
    *,
    schemas: List[CustomerCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_customer.bulkInsert(schemas=schemas, curr_user=current_user)
    return SuccessMessage(message=result_message)


@router.get("/", response_model=SuccessMessage[List[CustomerRead]])
async def get_all_customer(
    *,
    is_active: Optional[bool] = Query(None),
    is_approved: Optional[bool] = Query(None),
    with_sap: Optional[bool] = Query(None),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_obj = crud_customer.get_all(
        is_active=is_active, is_approved=is_approved, with_sap=with_sap
    )
    return {"count": result_obj.count(), "data": result_obj.all()}


@router.get("/{customer_code}", response_model=SuccessMessage[CustomerRead])
async def get_by_code(
    *,
    customer_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer.get(fk=customer_code)
    return SuccessMessage(data=result)


@router.get(
    "/by_location/{branchCode}", response_model=SuccessMessage[List[CustomerRead]]
)
async def get_all_customer(
    *,
    branchCode: str,
    is_active: Optional[bool] = Query(True),
    is_approved: Optional[bool] = Query(True),
    with_sap: Optional[bool] = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer.get_by_branch(
        branchCode=branchCode,
        is_active=is_active,
        is_approved=is_approved,
        with_sap=with_sap,
    )
    return {"data": result}


@router.put("/{customer_code}", response_model=SuccessMessage)
async def update(
    *,
    customer_code: str,
    schema: Dict[str, Any],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer.update(
        update_dict_data=schema, fk=customer_code, user_id=current_user.id
    )
    return SuccessMessage(message="Updated successfully", data=result)


@router.put("/by_field/{customer_code}", response_model=SuccessMessage[CustomerRead])
async def update_by_field(
    *,
    customer_code: str,
    schema: Dict[str, Any],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer.update_by_field(
        update_dict_data=schema, fk=customer_code, current_user=current_user
    )
    return {"message": "Updated successfully", "data": result}


@router.delete("/{customer_code}", response_model=SuccessMessage)
async def delete(
    *,
    customer_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer.remove(fk=customer_code)
    return SuccessMessage(message="Delete successfully", data=result)
