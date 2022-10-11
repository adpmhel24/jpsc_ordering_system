from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import PaymentTermsCreate, PaymentTermsRead, PaymentTermsUpdate
from .cruds import crud_payment_term
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
async def new(
    *,
    schema: PaymentTermsCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_payment_term.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully added!", data=result)


@router.get("/", response_model=SuccessMessage[List[PaymentTermsRead]])
async def get_all(
    *,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_payment_term.get_all()
    return {"data": result}


@router.get("/{payment_term_code}", response_model=SuccessMessage[PaymentTermsRead])
async def get_by_code(
    *,
    payment_term_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_payment_term.get(fk=payment_term_code)
    return SuccessMessage(data=result)


@router.put("/{payment_term_code}", response_model=SuccessMessage)
async def update(
    *,
    payment_term_code: str,
    schema: PaymentTermsUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_payment_term.update(update_schema=schema, fk=payment_term_code)
    return SuccessMessage(message="Updated successfully", data=result)
