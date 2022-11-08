from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from my_app.shared.custom_enums.enum_object_types import ObjectTypesEnum


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import ObjectTypeCreate, ObjectTypeRead
from .cruds import crud_objtype
from ..system_user.schemas import SystemUserRead

from my_app.dependencies import get_current_active_user, get_authorized_user


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def create(
    *,
    schema: ObjectTypeCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_objtype.create(create_schema=schema, user_id=current_user.id)
    return SuccessMessage(message="Successfully added!", data=result)


@router.get("/", response_model=SuccessMessage[List[ObjectTypeRead]])
async def get_all(
    *,
    is_active: Optional[bool] = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):

    result = crud_objtype.get_all(is_active=is_active)
    return {"data": result}
