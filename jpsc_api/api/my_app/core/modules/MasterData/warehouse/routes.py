from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from fastapi_pagination.ext.sqlalchemy import paginate

# Local Import
from my_app.shared.schemas.success_response import SuccessMessage
from my_app.dependencies import (
    get_current_active_user,
)
from ..system_user.schemas import SystemUserRead
from .schemas import WarehouseCreate, WarehouseRead, WarehouseUpdate
from .cruds import crud_whse


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage[WarehouseRead],
    status_code=status.HTTP_201_CREATED,
)
async def new_warehouse(
    *,
    schema: WarehouseCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_whse.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="New warehouse created", data=result)


@router.get("/", response_model=SuccessMessage[List[WarehouseRead]])
async def get_all_warehouse(
    *,
    is_active: Optional[bool] = Query(None),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_whse.get_all(is_active=is_active)
    return {"data": result}


@router.get("/{warehouse_code}", response_model=SuccessMessage[WarehouseRead])
async def get_by_code(
    *,
    warehouse_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_whse.get(fk=warehouse_code)
    return SuccessMessage(data=result)


@router.put("/{warehouse_code}", response_model=SuccessMessage)
async def update(
    *,
    warehouse_code: str,
    schema: WarehouseUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_whse.update(update_schema=schema, fk=warehouse_code)
    return SuccessMessage(message="Updated successfully", data=result)
