from my_app.shared.schemas.base_schemas import PrimaryKeyBase, UpdatedBase
from .base_model import ItemGroupUserAuthBase


class ItemGroupUserAuthCreate(ItemGroupUserAuthBase):
    pass


class ItemGroupUserAuthRead(UpdatedBase, ItemGroupUserAuthBase, PrimaryKeyBase):
    pass


class ItemGroupUserAuthUpdate(ItemGroupUserAuthBase, PrimaryKeyBase):
    pass
