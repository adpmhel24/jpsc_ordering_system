from typing import Optional
from datetime import datetime
from sqlalchemy.orm import relationship
from sqlmodel import Relationship, SQLModel, Field, text
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class ItemGroupBase(SQLModel):
    code: str = Field(primary_key=True, index=True)
    description: Optional[str] = Field(default=None, index=True)
    is_active: bool = Field(default=True, index=True)


class ItemGroup(UpdatedBase, CreatedBase, ItemGroupBase, table=True):
    __tablename__ = "item_group"

    items = Relationship(
        sa_relationship=relationship(
            "Item", passive_deletes="all", back_populates="item_group"
        )
    )
