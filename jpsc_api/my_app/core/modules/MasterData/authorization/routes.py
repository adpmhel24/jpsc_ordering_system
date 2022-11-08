from typing import List, Optional
from fastapi import APIRouter, Depends, Query


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import AuthorizationRead, AuthorizationUpdate
from .cruds import crud_auth


from my_app.dependencies import get_current_active_user, get_current_active_super_admin


router = APIRouter()


@router.get("/", response_model=SuccessMessage[List[AuthorizationRead]])
async def get_all(
    *,
    is_active: Optional[bool] = Query(True),
    current_user=Depends(get_current_active_user),
):
    result = crud_auth.get_all(is_active=is_active)
    return {"data": result}


@router.put("/bulk_update", response_model=SuccessMessage)
async def bulk_update(
    *,
    lists_to_update_dict: List[dict],
    current_user=Depends(get_current_active_super_admin),
):
    result_message = crud_auth.bulk_update(
        lists_to_update_dict=lists_to_update_dict, curr_user=current_user
    )
    return SuccessMessage(message=result_message)
