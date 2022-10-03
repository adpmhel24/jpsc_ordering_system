from typing import Any, Generator

from fastapi import Depends, HTTPException, status
from fastapi.security import OAuth2PasswordBearer
from jose import jwt
from pydantic import ValidationError
from sqlmodel import Session

from my_app.core.settings import settings

# from my_app.core.modules.MasterData.system_user.cruds import crud_sys_user
from .core.modules.MasterData.system_user.cruds import crud_sys_user
from my_app.shared.schemas.token_schema import TokenPayload
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead


reusable_oauth2 = OAuth2PasswordBearer(
    tokenUrl=f"{settings.API_V1_STR}/login/access-token"
)


def get_current_user(token: str = Depends(reusable_oauth2)) -> Any:
    try:
        payload = jwt.decode(
            token, settings.SECRET_KEY, algorithms=[settings.ALGORITHM]
        )
        token_data = TokenPayload(**payload)
    except (jwt.JWTError, ValidationError):
        raise HTTPException(
            status_code=status.HTTP_403_FORBIDDEN,
            detail="Could not validate credentials",
        )
    user = crud_sys_user.get(fk=token_data.sub)
    if not user:
        raise HTTPException(status_code=404, detail="User not found")
    return user


def get_current_active_user(
    current_user: SystemUserRead = Depends(get_current_user),
) -> Any:
    if not crud_sys_user.is_active(current_user):
        raise HTTPException(status_code=400, detail="Inactive user")
    return current_user


async def get_current_active_super_admin(
    current_user: SystemUserRead = Depends(get_current_user),
) -> SystemUserRead:
    if not crud_sys_user.is_super_admin(current_user):
        raise HTTPException(
            status_code=400, detail="The user doesn't have enough privileges"
        )
    return current_user


async def get_current_active_admin(
    current_user: SystemUserRead = Depends(get_current_user),
) -> SystemUserRead:
    if not crud_sys_user.is_super_admin(current_user):
        raise HTTPException(
            status_code=400, detail="The user doesn't have enough privileges"
        )
    return current_user
