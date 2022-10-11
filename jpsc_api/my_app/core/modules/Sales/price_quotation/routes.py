from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from my_app.shared.custom_enums.custom_enums import PQStatusEnum


# Local Import

from my_app.shared.schemas.success_response import SuccessMessage
from my_app.shared.custom_enums import DocstatusEnum
from my_app.dependencies import (
    get_current_active_user,
)
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead

from .schemas_header import (
    PriceQuotationHeaderCreate,
    PriceQuotationHeaderRead,
    PriceQuotationHeaderUpdate,
)
from .schemas_pq_comment import PriceQuotationCommentCreate


from .schemas_row import PriceQuotationRowCreate, PriceQuotationRowRead

from .cruds import crud_pq


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def create_price_quotation(
    *,
    header_schema: PriceQuotationHeaderCreate,
    rows_schema: List[PriceQuotationRowCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pq.create(
        header_schema=header_schema,
        rows_schema=rows_schema,
        user_id=current_user.id,
    )
    return SuccessMessage(message=f"PQ Ref. {result.reference}", data=result)


@router.get("/", response_model=SuccessMessage[List[PriceQuotationHeaderRead]])
async def get_all_price_quotation(
    *,
    docstatus: Optional[str] = Query(default=DocstatusEnum.open),
    pq_status: Optional[int] = Query(default=None),
    from_date: Optional[str] = Query(default=""),
    to_date: Optional[str] = Query(default=""),
    branch: Optional[str] = Query(default=""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pq.get_all(
        docstatus=docstatus,
        pq_status=pq_status,
        from_date=from_date,
        to_date=to_date,
        branch=branch,
    )
    others = {
        "for_price_confirmation": crud_pq.count_orders(
            docstatus=DocstatusEnum.open,
            pq_status=PQStatusEnum.for_price_confirmation,
        ),
        "for_credit_confirmation": crud_pq.count_orders(
            docstatus=DocstatusEnum.open,
            pq_status=PQStatusEnum.price_confirmed,
        ),
        "for_dispatch": crud_pq.count_orders(
            docstatus=DocstatusEnum.open,
            pq_status=PQStatusEnum.with_sap_sq,
        ),
    }
    return {"others": others, "data": result}


@router.get("/by_owner", response_model=SuccessMessage[List[PriceQuotationHeaderRead]])
async def get_all_price_quotations_by_created_by(
    *,
    docstatus: Optional[str] = Query(default=DocstatusEnum.open),
    pq_status: Optional[int] = Query(default=PQStatusEnum.for_price_confirmation),
    from_date: Optional[str] = Query(default=""),
    to_date: Optional[str] = Query(default=""),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pq.get_all_by_owner(
        docstatus=docstatus,
        pq_status=pq_status,
        from_date=from_date,
        to_date=to_date,
        user_id=current_user.id,
    )

    return {"data": result}


@router.put("/", response_model=SuccessMessage)
async def udpatePriceQuotation(
    *,
    schema: PriceQuotationHeaderUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    message = crud_pq.update(
        schema=schema,
        user_id=current_user.id,
    )
    return {"message": message}


@router.put("/cancel/{id}", response_model=SuccessMessage)
async def cancel(
    *,
    id: int,
    schema: PriceQuotationCommentCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_pq.cancel(id=id, schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully canceled.", data=result)
