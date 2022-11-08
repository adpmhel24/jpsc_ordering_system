from typing import List
from fastapi import APIRouter, Depends, Query, status
from sqlmodel import Session

# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.dependencies import (
    get_current_active_user,
)
from ..system_user.schemas import SystemUserRead
from .schemas import UoMCreate, UoMUpdate, UoMRead
from .cruds import crud_uom


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_uom(
    *,
    schema: UoMCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="New UoM created", data=result)


@router.get("/", response_model=SuccessMessage[List[UoMRead]])
async def get_all_uom(
    *,
    is_active: bool = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom.get_all(is_active=is_active)
    return {"data": result}


@router.get("/{uom_code}", response_model=SuccessMessage[UoMRead])
async def get_by_code(
    *,
    uom_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom.get(fk=uom_code)
    return SuccessMessage(data=result)


@router.put("/{uom_code}", response_model=SuccessMessage[UoMRead])
async def update(
    *,
    uom_code: str,
    schema: UoMUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom.update(update_schema=schema, fk=uom_code)
    return SuccessMessage(message="Updated successfully", data=result)


@router.post("/bulk_insert", response_model=SuccessMessage)
async def bulkInsert(
    *,
    schemas: List[UoMCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_uom.bulkInsert(schemas=schemas, curr_user=current_user)
    return SuccessMessage(message=result_message)
