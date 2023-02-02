from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status


# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.dependencies import (
    get_current_active_user,
)
from ..system_user.schemas import SystemUserRead
from .schemas import (
    ItemRead,
    ItemCreate,
    ItemUpdate,
)
from .cruds import crud_item


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_item(
    *,
    schema: ItemCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Created successfully", data=result)


@router.get("/", response_model=SuccessMessage[List[ItemRead]])
async def get_all_item(
    *,
    is_active: bool = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item.get_all(is_active=is_active)
    return {"data": result}


@router.get("/{item_code}", response_model=SuccessMessage[Optional[ItemRead]])
async def get_by_code(
    *,
    item_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item.get(fk=item_code)
    return SuccessMessage(data=result)


@router.get(
    "/with_price/by_branch/{branch_code}", response_model=SuccessMessage[List[ItemRead]]
)
async def getItemWithPriceByBranch(
    *,
    branch_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item.get_items_with_price_by_branch(branch_code=branch_code)
    return {"data": result}


@router.put("/{item_code}", response_model=SuccessMessage[ItemRead])
async def update(
    *,
    item_code: str,
    schema: ItemUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_item.update(update_schema=schema, fk=item_code)
    return SuccessMessage(message="Updated successfully", data=result)


@router.post("/bulk_insert", response_model=SuccessMessage)
async def bulkInsert(
    *,
    schemas: List[ItemCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_item.bulkInsert(schemas=schemas, curr_user=current_user)
    return SuccessMessage(message=result_message)
