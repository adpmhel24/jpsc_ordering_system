from typing import Optional
from sqlmodel import SQLModel, Field

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class ItemGroupBase(SQLModel):
    code: str = Field(primary_key=True, index=True)
    description: Optional[str] = Field(default=None, index=True)
    is_active: bool = Field(default=True, index=True)


class ItemGroupCreate(ItemGroupBase):
    pass


class ItemGroupUpdate(ItemGroupBase):
    pass


class ItemGroupRead(UpdatedBase, CreatedBase, ItemGroupBase):
    pass
