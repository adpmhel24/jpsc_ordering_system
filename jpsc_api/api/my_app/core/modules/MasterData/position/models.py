from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase
from .schemas import PositionBase


class Position(CreatedBase, UpdatedBase, PositionBase, table=True):
    """System User Database Model"""

    __tablename__ = "position"
