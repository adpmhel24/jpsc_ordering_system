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
from .schemas_row import PricelistRowRead, PricelistRowUpdate
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


@router.get("/", response_model=SuccessMessage[List[PricelistHeaderRead]])
async def get_all_pricelist(
    *,
    is_active: bool = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.get_all(is_active=is_active)
    return {"data": result}


@router.get(
    "/{pricelist_code}", response_model=SuccessMessage[Optional[PricelistHeaderRead]]
)
async def get_by_code(
    *,
    pricelist_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.get(fk=pricelist_code)
    return SuccessMessage(data=result)


@router.get(
    "/pricelist_row/by_branch/{branch_code}",
    response_model=SuccessMessage[List[Optional[PricelistRowRead]]],
)
async def get_pricelist_by_branch(
    *,
    branch_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.get_item_price_by_branch(branch_code=branch_code)
    return SuccessMessage(data=result)


@router.put("/pricelist_rows", response_model=SuccessMessage)
async def pricelist_rows_bulk_update(
    *,
    pricelistRows: List[PricelistRowUpdate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pricelist.update_rows(
        pricelistRows=pricelistRows, user_id=current_user.id
    )
    return SuccessMessage(message="Updated successfully")
