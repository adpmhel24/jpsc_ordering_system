from typing import List, Optional
from fastapi import APIRouter, Depends, Query, Request, UploadFile, Form


from my_app.shared.schemas.success_response import SuccessMessage
from .schemas import AppVersionRead, AppVersionCreate, AppVersionUpdate
from .cruds import crud_app_version


from my_app.dependencies import get_current_active_user, get_current_active_super_admin


router = APIRouter()


@router.post("/", response_model=SuccessMessage[AppVersionRead])
async def create(
    *,
    platform: str = Form(...),
    app_name: str = Form(...),
    package_name: str = Form(...),
    version: str = Form(...),
    build_number: str = Form(...),
    is_active: bool = Form(...),
    file: UploadFile,
    current_user=Depends(get_current_active_super_admin),
):
    result = await crud_app_version.create(
        platform=platform,
        app_name=app_name,
        package_name=package_name,
        version=version,
        build_number=build_number,
        is_active=is_active,
        file=file,
        current_user=current_user,
    )
    return {"message": "Successfully added.", "data": result}


@router.get("/", response_model=SuccessMessage[List[AppVersionRead]])
async def get_all(
    *,
    is_active: Optional[bool] = Query(True),
    current_user=Depends(get_current_active_super_admin),
):
    result = crud_app_version.get_all()
    return {"data": result}


@router.get("/latest", response_model=SuccessMessage[Optional[AppVersionRead]])
async def get_latest(
    params: Request,
):
    result = crud_app_version.get_active_version(params_dict=params.query_params._dict)
    return {"data": result}
