from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase
from .models import ItemGroupBase


class ItemGroupCreate(ItemGroupBase):
    pass


class ItemGroupUpdate(ItemGroupBase):
    pass


class ItemGroupRead(UpdatedBase, CreatedBase, ItemGroupBase):
    pass
