from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from sqlmodel import Session


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import MenuGroupCreate, MenuGroupRead, MenuGroupUpdate
from .cruds import crud_menu_group
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
async def create(
    *,
    schema: MenuGroupCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_menu_group.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully added!", data=result)


@router.get("/", response_model=SuccessMessage[List[MenuGroupRead]])
async def get_all(
    *,
    is_active: Optional[bool] = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_menu_group.get_all(is_active=is_active)
    return {"data": result}
