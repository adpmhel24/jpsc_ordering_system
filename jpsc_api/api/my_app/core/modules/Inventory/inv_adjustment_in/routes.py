from typing import Optional
from fastapi import APIRouter, Depends, Query, status


# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.shared.custom_enums import DocstatusEnum
from my_app.dependencies import (
    get_current_active_user,
)
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.core.modules.Inventory.inv_adjustment_in.schemas_header import (
    InvAdjustmentInHeaderCreate,
    InvAdjustmentInHeaderRead,
    InvAdjustmentInHeaderCancel,
)
from my_app.core.modules.Inventory.inv_adjustment_in.schemas_row import (
    InvAdjustmentInRowCreate,
)
from my_app.core.modules.Inventory.inv_adjustment_in.cruds import crud_adj_in


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def create_adjustment_in(
    *,
    header_schema: InvAdjustmentInHeaderCreate,
    rows_schema: list[InvAdjustmentInRowCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_adj_in.create(
        header_schema=header_schema,
        rows_schema=rows_schema,
        user_id=current_user.id,
    )
    return SuccessMessage(message="Successfully added", data=result)


@router.get("/", response_model=SuccessMessage[list[InvAdjustmentInHeaderRead]])
async def get_all_adjustment_in(
    *,
    docstatus: Optional[DocstatusEnum] = Query(default=DocstatusEnum.closed),
    from_date: Optional[str] = Query(default=""),
    to_date: Optional[str] = Query(default=""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_adj_in.get_all(
        docstatus=docstatus,
        from_date=from_date,
        to_date=to_date,
    )
    return {"data": result}


@router.get("/{id}", response_model=SuccessMessage[Optional[InvAdjustmentInHeaderRead]])
async def get_details(
    *,
    id: int,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_adj_in.get(fk=id)
    return {"data": result}


@router.put("/cancel/{id}", response_model=SuccessMessage)
async def cancel(
    *,
    id: int,
    schema: InvAdjustmentInHeaderCancel,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_adj_in.cancel(id=id, schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully canceled.", data=result)
