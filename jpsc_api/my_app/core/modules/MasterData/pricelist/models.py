from typing import List
from sqlmodel import Relationship

from .schemas_header import PricelistHeaderBase
from .schemas_row import PricelistRowBase


from my_app.shared.schemas.base_schemas import CreatedBase, PrimaryKeyBase, UpdatedBase


class PricelistHeader(UpdatedBase, CreatedBase, PricelistHeaderBase, table=True):
    __tablename__ = "pricelist_h"

    rows: List["PricelistRow"] = Relationship(
        back_populates="header",
    )


class PricelistRow(UpdatedBase, PricelistRowBase, PrimaryKeyBase, table=True):
    __tablename__ = "pricelist_r"

    header: "PricelistHeader" = Relationship(
        back_populates="rows",
    )
