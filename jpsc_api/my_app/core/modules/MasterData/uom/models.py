from typing import TYPE_CHECKING
from sqlmodel import Relationship
from sqlalchemy.orm import relationship
from my_app.shared.schemas.base_schemas import CreatedBase, PrimaryKeyBase, UpdatedBase
from .schemas import UoMBase

if TYPE_CHECKING:
    from ..item import Item


class UoM(UpdatedBase, CreatedBase, UoMBase, table=True):
    """Database Model"""

    __tablename__ = "uom"

    item_sales_uom = Relationship(
        sa_relationship=relationship(
            "Item",
            primaryjoin="Item.sale_uom_code == UoM.code",
            passive_deletes="all",
        )
    )
