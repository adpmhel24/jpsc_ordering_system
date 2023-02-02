from typing import TYPE_CHECKING
from sqlalchemy.orm import relationship
from sqlmodel import Relationship
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase
from .schemas import UomGroupBase

if TYPE_CHECKING:
    from . import AltUom


class UomGroup(UpdatedBase, CreatedBase, UomGroupBase, table=True):
    """Database Model"""

    __tablename__ = "uom_group"

    alt_uoms = Relationship(
        sa_relationship=relationship("AltUom"),
    )
