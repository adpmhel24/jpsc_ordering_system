from fastapi import APIRouter, Depends, status


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import CustomerAddressCreate
from .cruds import crud_customer_address
from ..system_user.schemas import SystemUserRead

from my_app.dependencies import (
    get_current_active_user,
)


router = APIRouter()


@router.post(
    "/{customer_code}/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_address(
    *,
    customer_code: str,
    schema: CustomerAddressCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_customer_address.create(
        customer_code=customer_code, schema=schema, current_user=current_user
    )
    return SuccessMessage(message="Successfully added!", data=result)
