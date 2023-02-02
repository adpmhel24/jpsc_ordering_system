from typing import Optional
from fastapi import APIRouter, Depends, Query, status


# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.shared.custom_enums import DocstatusEnum
from my_app.dependencies import (
    get_current_active_user,
)
from ...MasterData.system_user.schemas import SystemUserRead
from .schemas_header import InvReceiveHeaderCreate, InvReceiveHeaderRead
from .schemas_row import InvReceiveRowCreate
from .cruds import crud_inv_rec


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def create_inv_receive(
    *,
    header_schema: InvReceiveHeaderCreate,
    rows_schema: list[InvReceiveRowCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_inv_rec.create(
        header_schema=header_schema,
        rows_schema=rows_schema,
        user_id=current_user.id,
    )
    return SuccessMessage(message="Successfully added", data=result)


@router.get("/", response_model=SuccessMessage[list[InvReceiveHeaderRead]])
async def get_all_inv_receive(
    *,
    docstatus: Optional[DocstatusEnum] = Query(default=DocstatusEnum.open),
    from_date: Optional[str] = Query(default=""),
    to_date: Optional[str] = Query(default=""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_inv_rec.get_all(
        docstatus=docstatus,
        from_date=from_date,
        to_date=to_date,
    )
    return {"data": result}
