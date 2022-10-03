from typing import TYPE_CHECKING, List, Optional
from sqlmodel import Relationship
from sqlalchemy.orm import relationship

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase
from .schemas import OtherField, WarehouseBase


if TYPE_CHECKING:
    from ..branch import Branch


class Warehouse(UpdatedBase, CreatedBase, OtherField, WarehouseBase, table=True):

    """Database Model"""

    __tablename__ = "warehouse"

    branch: Optional["Branch"] = Relationship(
        sa_relationship=relationship(
            "Branch",
            viewonly=True,
        ),
    )
