from locale import currency
from typing import List, Optional
from fastapi import APIRouter, Depends, Query
from my_app.shared.custom_enums.enum_object_types import ObjectTypesEnum


from my_app.shared.schemas.success_response import SuccessMessage
from .crud import crud_item_group_auth


from my_app.dependencies import get_current_active_super_admin


router = APIRouter()


@router.put("/bulk_update", response_model=SuccessMessage)
async def bulk_update(
    *,
    lists_to_update_dict: List[dict],
    current_user=Depends(get_current_active_super_admin),
):

    result_message = crud_item_group_auth.bulk_update(
        lists_to_update_dict=lists_to_update_dict, curr_user=current_user
    )
    return SuccessMessage(message=result_message)
