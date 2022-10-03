from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase
from .schemas import AltUomBase


class AltUom(UpdatedBase, CreatedBase, AltUomBase, PrimaryKeyBase, table=True):
    """Database Model"""

    __tablename__ = "alt_uom"
