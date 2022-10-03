from typing import List
from fastapi import APIRouter, Depends, Query, status
from pydantic import EmailStr

from my_app.dependencies import get_current_active_user

from my_app.shared.schemas.success_response import SuccessMessage

from ..system_user.schemas import SystemUserRead
from .cruds import crud_sys_user_branch
from .schemas import (
    SystemUserBranchCreate,
    SystemUserBranchRead,
    SystemUserBranchUpdate,
)


router = APIRouter()


@router.post("/", status_code=status.HTTP_201_CREATED, response_model=SuccessMessage)
async def new(
    schema: SystemUserBranchCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user_branch.create(schema=schema)
    return SuccessMessage(message="Added successfully!")


@router.get("/{user_id}", response_model=SuccessMessage[List[SystemUserBranchRead]])
async def get_assigned_branch_by_user(
    *,
    user_id: int,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user_branch.get_assigned_branch(system_user_id=user_id)
    return SuccessMessage(data=result)


@router.get(
    "/by_email/{email}", response_model=SuccessMessage[List[SystemUserBranchRead]]
)
async def get_assigned_branch_by_email(
    *,
    email: EmailStr,
):
    result = crud_sys_user_branch.get_assigned_branch_by_email(email=email)
    return SuccessMessage(data=result)


@router.put("/", response_model=SuccessMessage)
async def update_assigned_branch(
    *,
    schema: List[SystemUserBranchUpdate],
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_sys_user_branch.update_assigned_branch(obj_in=schema)
    return SuccessMessage(message="Successfully updated!")
