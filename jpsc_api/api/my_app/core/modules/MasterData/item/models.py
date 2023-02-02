from typing import TYPE_CHECKING
from sqlmodel import Relationship
from sqlalchemy.orm import relationship
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase

from .schemas import OtherField, ItemBase

if TYPE_CHECKING:
    from ..uom.models import UoM
    from ..item_group.models import ItemGroup


class Item(UpdatedBase, CreatedBase, OtherField, ItemBase, table=True):
    """Database Model"""

    __tablename__ = "item"

    item_group = Relationship(
        sa_relationship=relationship("ItemGroup", back_populates="items", viewonly=True)
    )

    sale_uom = Relationship(
        sa_relationship=relationship(
            "UoM", primaryjoin="Item.sale_uom_code == UoM.code", viewonly=True
        )
    )
