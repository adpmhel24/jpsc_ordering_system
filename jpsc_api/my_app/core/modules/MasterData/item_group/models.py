from typing import TYPE_CHECKING
from sqlalchemy.orm import relationship
from sqlmodel import Relationship
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase
from .schemas import ItemGroupBase

if TYPE_CHECKING:
    # TODO
    pass


class ItemGroup(UpdatedBase, CreatedBase, ItemGroupBase, table=True):
    __tablename__ = "item_group"

    items = Relationship(
        sa_relationship=relationship(
            "Item", passive_deletes="all", back_populates="item_group"
        )
    )
