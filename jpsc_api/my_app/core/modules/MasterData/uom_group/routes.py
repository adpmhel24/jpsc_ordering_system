from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from sqlmodel import Session
from fastapi_pagination.ext.sqlalchemy import paginate

# Local Import
from my_app.shared.schemas.success_response import SuccessMessage
from my_app.dependencies import (
    get_current_active_user,
)
from ..alt_uom.schemas import AltUomCreate
from ..system_user.schemas import SystemUserRead
from .schemas import UomGroupCreate, UomGroupRead, UomGroupUpdate
from .cruds import crud_uom_grp


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_uom_group(
    *,
    uom_grp_schema: UomGroupCreate,
    alt_uom_schemas: Optional[List[AltUomCreate]],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom_grp.create(
        uom_grp_schema=uom_grp_schema,
        alt_uoms_schema=alt_uom_schemas,
        user_id=current_user.id,
    )
    return SuccessMessage(message="Successfully created.", data=result)


@router.get("/", response_model=SuccessMessage[List[UomGroupRead]])
async def get_all_uom_group(
    *,
    is_active: bool = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom_grp.get_all(is_active=is_active)
    return {"data": result}


@router.get("/{uom_grp_name}", response_model=SuccessMessage[UomGroupRead])
async def get_by_name(
    *,
    uom_grp_name: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom_grp.get(fk=uom_grp_name)
    return SuccessMessage(data=result)


@router.put("/{uom_grp_name}", response_model=SuccessMessage[UomGroupRead])
async def update(
    *,
    uom_grp_name: str,
    schema: UomGroupUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_uom_grp.update(update_schema=schema, fk=uom_grp_name)
    return SuccessMessage(message="Update successfully", data=result)
