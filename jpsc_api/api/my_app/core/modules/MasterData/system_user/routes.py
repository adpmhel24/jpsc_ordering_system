from typing import Any, List
from fastapi import APIRouter, Depends, Query, status


# Local Import
from my_app.shared.schemas.success_response import SuccessMessage
from my_app.dependencies import (
    get_current_active_user,
)
from .cruds import crud_sys_user
from .schemas import SystemUserCreate, SystemUserRead, SystemUserUpdate


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage[SystemUserRead],
    status_code=status.HTTP_201_CREATED,
)
def create_system_user(
    *,
    schema: SystemUserCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
) -> Any:

    result = crud_sys_user.create(create_schema=schema)
    return SuccessMessage(message="Successfully created!", data=result)


@router.get(
    "/",
    response_model=SuccessMessage[List[SystemUserRead]],
)
def get_all_users(
    is_active: bool = Query(True),
    *,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user.get_all_user(is_active=is_active)
    return {"data": result}


@router.get("/current_user", response_model=SuccessMessage[SystemUserRead])
def get_current_user(
    *,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    return SuccessMessage(data=current_user)


@router.get("/{user_id}", response_model=SuccessMessage[SystemUserRead])
def get_by_id(
    *,
    user_id: int,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user.get(fk=user_id)
    return {"data": result}


@router.post("/bulk_insert", response_model=SuccessMessage)
async def bulk_insert(
    *,
    schemas: List[SystemUserCreate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_sys_user.bulkInsert(schemas=schemas, curr_user=current_user)
    return SuccessMessage(message=result_message)


@router.put("/change_password", response_model=SuccessMessage)
async def change_pasword(
    *,
    data_dict: dict,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result_message = crud_sys_user.change_password(
        data_dict=data_dict, current_user=current_user
    )
    return SuccessMessage(message=result_message)


@router.put("/{user_id}", response_model=SuccessMessage[SystemUserRead])
async def update(
    *,
    user_id: int,
    schema: SystemUserUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user.update(fk=user_id, obj_in=schema)
    return SuccessMessage(message="Updated Successfully", data=result)


@router.delete("/{user_id}", response_model=SuccessMessage)
def delete_user(
    *,
    user_id: int,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user.remove(
        id=user_id,
        sequence="system_user_id_seq",
    )
    return SuccessMessage(message="Deleted", data=result)
