from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import PositionCreate, PositionRead, PositionUpdate
from .cruds import crud_position
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
    schema: PositionCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_position.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully added!", data=result)


@router.get("/", response_model=SuccessMessage[List[PositionRead]])
async def get_all(
    *,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_position.get_all()
    return {"data": result}


@router.get("/{position_code}", response_model=SuccessMessage[PositionRead])
async def get_by_code(
    *,
    position_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_position.get(fk=position_code)
    return SuccessMessage(data=result)


@router.put("/{position_code}", response_model=SuccessMessage)
async def update(
    *,
    position_code: str,
    schema: PositionUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_position.update(update_schema=schema, fk=position_code)
    return SuccessMessage(message="Updated successfully", data=result)
