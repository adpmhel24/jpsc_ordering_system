from typing import TYPE_CHECKING
from sqlmodel import Relationship
from sqlalchemy.orm import relationship
from .schemas import UpdatedBase, CreatedBase, BranchBase

if TYPE_CHECKING:
    from ..pricelist.models import PricelistHeader


class Branch(UpdatedBase, CreatedBase, BranchBase, table=True):
    """Branch Database Model"""

    pricelist: "PricelistHeader" = Relationship(
        sa_relationship=relationship("PricelistHeader")
    )
