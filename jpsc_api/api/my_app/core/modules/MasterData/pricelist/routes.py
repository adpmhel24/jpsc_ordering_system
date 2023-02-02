from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status


# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.dependencies import (
    get_current_active_user,
)
from ..system_user.schemas import SystemUserRead
from .schemas_header import (
    PricelistHeaderRead,
    PricelistHeaderCreate,
)
from .models import PricelistHeader
from .schemas_row import PricelistRowRead, PricelistRowUpdate, PricelistRowLogsRead
from .cruds import crud_pricelist


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_pricelist(
    *,
    schema: PricelistHeaderCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Created successfully", data=result)


@router.get("/", response_model=SuccessMessage[List[PricelistHeader]])
async def get_all_pricelist(
    *,
    is_active: bool = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.get_all(is_active=is_active)
    return {"data": result}


@router.put("/{pricelist_code}", response_model=SuccessMessage)
async def get_by_code(
    *,
    pricelist_code: str,
    schema: PricelistHeaderCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_pricelist.udpate_pricelist_header(
        fk=pricelist_code, data_dict=schema.dict(), current_user=current_user
    )
    return SuccessMessage(message=result_message)


@router.get("/{pricelist_code}", response_model=SuccessMessage[PricelistHeaderRead])
async def get_by_code(
    *,
    pricelist_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = await crud_pricelist.getPricelistRowByPricelistCode(fk=pricelist_code)
    return {"data": result}


@router.get(
    "/rows/by_item/",
    response_model=SuccessMessage[List[Optional[PricelistRowRead]]],
)
async def get_pricelist_r_by_item_code(
    *,
    item_code: str = Query(""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = await crud_pricelist.get_pricelist_r_by_item_code(item_code=item_code)
    return {"data": result}


@router.get(
    "/rows/by_branch/{branch_code}",
    response_model=SuccessMessage[List[Optional[PricelistRowRead]]],
)
async def get_pricelist_r_by_branch(
    *,
    branch_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.get_pricelist_r_by_branch(branch_code=branch_code)
    return {"data": result}


@router.get(
    "/rows/logs/{pricelist_row_id}",
    response_model=SuccessMessage[List[PricelistRowLogsRead]],
)
async def get_pricelist_r_logs(
    *,
    pricelist_row_id: int,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.get_pricelist_row_logs(pricelist_row_id=pricelist_row_id)
    return {"data": result}


@router.put("/rows/bulk_update", response_model=SuccessMessage)
async def pricelist_rows_bulk_update(
    *,
    pricelistRows: List[PricelistRowUpdate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_pricelist.update_rows(
        pricelistRows=pricelistRows, current_user=current_user
    )
    return SuccessMessage(message=result_message)
