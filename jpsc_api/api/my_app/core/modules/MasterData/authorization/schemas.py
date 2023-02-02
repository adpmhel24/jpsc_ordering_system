from typing import Optional
from my_app.shared.schemas.base_schemas import PrimaryKeyBase, UpdatedBase
from .models import AuthorizationBase


class AuthorizationCreate(AuthorizationBase):
    pass


class AuthorizationRead(UpdatedBase, AuthorizationBase, PrimaryKeyBase):
    object_type_obj: Optional["ObjectTypeRead"]


class AuthorizationUpdate(UpdatedBase, AuthorizationBase, PrimaryKeyBase):
    pass


from ..object_type.schemas import ObjectTypeRead

AuthorizationRead.update_forward_refs()
