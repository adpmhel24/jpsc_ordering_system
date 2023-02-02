from datetime import datetime, timedelta
from typing import Any
from fastapi import APIRouter, Depends, HTTPException
from fastapi.security import OAuth2PasswordRequestForm
from fastapi_sqlalchemy import db
from my_app.shared.schemas.success_response import SuccessMessage

# Local Import

from my_app.shared.schemas.token_schema import Token
from my_app.core.settings import security
from my_app.core.settings.config import settings
from ..MasterData.system_user import cruds
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.dependencies import get_current_active_user

router = APIRouter()


@router.post("/login/access-token", response_model=Token)
def login_access_token(
    form_data: OAuth2PasswordRequestForm = Depends(),
) -> Any:
    """
    OAuth2 compatible token login, get an access token for future requests
    """
    user = cruds.crud_sys_user.authenticate(
        email=form_data.username, password=form_data.password
    )
    if not user:
        raise HTTPException(status_code=400, detail="Incorrect email or password")
    elif not cruds.crud_sys_user.is_active(user):
        raise HTTPException(status_code=400, detail="Inactive user")
    access_token_expires = timedelta(minutes=settings.ACCESS_TOKEN_EXPIRE_MINUTES)
    user.last_login = datetime.now()
    db.session.commit()
    db.session.refresh(user)
    return {
        "data": user,
        "access_token": security.create_access_token(
            user.id, expires_delta=access_token_expires
        ),
        "token_type": "Bearer",
    }


@router.post("/try_login", response_model=SuccessMessage[SystemUserRead])
def try_login(current_user: SystemUserRead = Depends(get_current_active_user)):

    return {
        "data": current_user,
    }
