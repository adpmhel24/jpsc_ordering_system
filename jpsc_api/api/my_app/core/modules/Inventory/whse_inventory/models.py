from my_app.shared.schemas.base_schemas import PrimaryKeyBase
from .schema import WhseInvBase


class WhseInv(WhseInvBase, PrimaryKeyBase, table=True):
    __tablename__ = "whseinv"
    pass
