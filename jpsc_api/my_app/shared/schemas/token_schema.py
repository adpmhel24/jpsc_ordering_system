from typing import Optional

from pydantic import BaseModel
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead


class Token(BaseModel):
    data: SystemUserRead
    access_token: str
    token_type: str


class TokenPayload(BaseModel):
    sub: Optional[int] = None
