from typing import List, Optional
from fastapi import APIRouter, Depends, Query, status
from sqlmodel import Session
from my_app.shared.custom_enums.enum_object_types import ObjectTypesEnum


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import BranchCreate, BranchRead, BranchUpdate
from .cruds import crud_branch
from ..system_user.schemas import SystemUserRead

from my_app.dependencies import get_current_active_user, get_authorized_user


router = APIRouter()


@router.post(
    "/",
    response_model=SuccessMessage,
    status_code=status.HTTP_201_CREATED,
)
async def new_branch(
    *,
    schema: BranchCreate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    # Check if the user is authorized

    result = crud_branch.create(create_schema=schema, current_user=current_user)
    return SuccessMessage(message="Successfully added!", data=result)


@router.get("/", response_model=SuccessMessage[List[BranchRead]])
async def get_all_branch(
    *,
    is_active: Optional[bool] = Query(True),
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_branch.get_all(is_active=is_active)
    return {"data": result}


@router.get("/{branch_code}", response_model=SuccessMessage[BranchRead])
async def get_by_code(
    *,
    branch_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_branch.get(fk=branch_code)
    return SuccessMessage(data=result)


@router.put("/{branch_code}", response_model=SuccessMessage)
async def update(
    *,
    branch_code: str,
    schema: BranchUpdate,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_branch.update(
        update_schema=schema, fk=branch_code, current_user=current_user
    )
    return SuccessMessage(message="Updated successfully", data=result)


@router.delete("/{branch_code}", response_model=SuccessMessage)
async def delete(
    *,
    branch_code: str,
    current_user: SystemUserRead = Depends(get_current_active_user),
):
    result = crud_branch.remove(fk=branch_code)
    return SuccessMessage(message="Delete successfully", data=result)
