from typing import List
from fastapi import APIRouter, Depends, Query, status
from fastapi_pagination.ext.sqlalchemy import paginate

# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from ..system_user.schemas import SystemUserRead
from .cruds import crud_item_grp
from .schemas import (
    ItemGroupCreate,
    ItemGroupRead,
    ItemGroupUpdate,
)

from my_app.dependencies import (
    get_current_active_user,
)


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_item_group(
    *,
    schema: ItemGroupCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item_grp.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Created successfully", data=result)


@router.get("/", response_model=SuccessMessage[List[ItemGroupRead]])
async def get_item_group(
    *,
    is_active: bool = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item_grp.get_all(is_active=is_active)
    return {"data": result}


@router.get("/{item_grp_code}", response_model=SuccessMessage[ItemGroupRead])
async def get_by_code(
    *,
    item_grp_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item_grp.get(fk=item_grp_code)
    return SuccessMessage(data=result)


@router.put("/{item_grp_code}", response_model=SuccessMessage[ItemGroupRead])
async def update(
    *,
    item_grp_code: str,
    schema: ItemGroupUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item_grp.update(update_schema=schema, fk=item_grp_code)
    return SuccessMessage(message="Updated successfully", data=result)


@router.post("/bulk_insert", response_model=SuccessMessage)
async def bulkInsert(
    *,
    schemas: List[ItemGroupCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_item_grp.bulkInsert(schemas=schemas, curr_user=current_user)
    return SuccessMessage(message=result_message)
