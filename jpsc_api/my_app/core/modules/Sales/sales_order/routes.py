from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from my_app.shared.custom_enums.custom_enums import OrderStatusEnum


# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.shared.custom_enums import DocstatusEnum
from my_app.dependencies import (
    get_current_active_user,
)
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead

from .schemas_header import (
    SalesOrderHeaderCreate,
    SalesOrderHeaderRead,
    SalesOrderHeaderUpdate,
)
from .schemas_so_comment import SalesOrderCommentCreate


from .schemas_row import SalesOrderRowCreate, SalesOrderRowRead

from .cruds import crud_so


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def create_sales_order(
    *,
    header_schema: SalesOrderHeaderCreate,
    rows_schema: List[SalesOrderRowCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_so.create(
        header_schema=header_schema,
        rows_schema=rows_schema,
        user_id=current_user.id,
    )
    return SuccessMessage(message=f"Order No. {result.reference}", data=result)


@router.get("/", response_model=SuccessMessage[List[SalesOrderHeaderRead]])
async def get_all_sales_orders_by_created_by(
    *,
    docstatus: Optional[str] = Query(default=DocstatusEnum.open),
    order_status: Optional[int] = Query(default=None),
    from_date: Optional[str] = Query(default=""),
    to_date: Optional[str] = Query(default=""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_so.get_all(
        docstatus=docstatus,
        order_status=order_status,
        from_date=from_date,
        to_date=to_date,
    )
    return {"data": result}


@router.get("/by_owner", response_model=SuccessMessage[List[SalesOrderHeaderRead]])
async def get_all_sales_orders_by_created_by(
    *,
    docstatus: Optional[str] = Query(default=DocstatusEnum.open),
    order_status: Optional[int] = Query(default=OrderStatusEnum.for_price_confirmation),
    from_date: Optional[str] = Query(default=""),
    to_date: Optional[str] = Query(default=""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_so.get_all_by_owner(
        docstatus=docstatus,
        order_status=order_status,
        from_date=from_date,
        to_date=to_date,
        user_id=current_user.id,
    )
    return {"data": result}


@router.put("/", response_model=SuccessMessage)
async def udpateSalesOrder(
    *,
    schema: SalesOrderHeaderUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_so.update(
        schema=schema,
        user_id=current_user.id,
    )
    return {"data": result}


@router.put("/cancel/{id}", response_model=SuccessMessage)
async def cancel(
    *,
    id: int,
    schema: SalesOrderCommentCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_so.cancel(id=id, schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully canceled.", data=result)
