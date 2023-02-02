from datetime import datetime
from pydantic import condecimal
from sqlmodel import Relationship, SQLModel, Field, text
from typing import TYPE_CHECKING, List, Optional
from sqlalchemy.orm import relationship


from my_app.shared.schemas.base_schemas import CreatedBase, PrimaryKeyBase, UpdatedBase

if TYPE_CHECKING:
    from ..item.models import Item
    from ..system_user.models import SystemUser


class PricelistHeaderBase(SQLModel):
    code: str = Field(primary_key=True, sa_column_kwargs={"unique": True}, index=True)
    description: Optional[str]
    is_active: bool = Field(sa_column_kwargs={"server_default": text("true")})


class PricelistRowBase(SQLModel):
    pricelist_code: str = Field(
        foreign_key="pricelist_h.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )
    item_code: str = Field(
        foreign_key="item.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )
    price: condecimal(max_digits=10, decimal_places=2) = Field(
        sa_column_kwargs={"server_default": text("0.00")}
    )
    logistics_cost: Optional[condecimal(max_digits=10, decimal_places=2)] = Field(
        sa_column_kwargs={"server_default": text("0.00")}
    )
    profit: Optional[condecimal(max_digits=10, decimal_places=2)] = Field(
        sa_column_kwargs={"server_default": text("0.00")}
    )
    uom_code: Optional[str] = Field(
        foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"}
    )


class AdditionalPricelistRowCol(SQLModel):
    last_purchase_price: Optional[condecimal(max_digits=10, decimal_places=2)] = Field(
        sa_column_kwargs={"server_default": text("0.00")}
    )
    avg_sap_value: Optional[condecimal(max_digits=10, decimal_places=2)] = Field(
        sa_column_kwargs={"server_default": text("0.00")}
    )


class PricelistHeader(UpdatedBase, CreatedBase, PricelistHeaderBase, table=True):
    __tablename__ = "pricelist_h"

    rows: List["PricelistRow"] = Relationship(
        back_populates="header",
        sa_relationship=relationship(
            "PricelistRow",
            order_by="PricelistRow.item_code",
        ),
    )


class PricelistRow(
    UpdatedBase, PricelistRowBase, AdditionalPricelistRowCol, PrimaryKeyBase, table=True
):
    __tablename__ = "pricelist_r"

    header: "PricelistHeader" = Relationship(
        back_populates="rows",
    )
    item: "Item" = Relationship(sa_relationship=relationship("Item", lazy=True))


class PricelistRowLogs(
    PricelistRowBase, AdditionalPricelistRowCol, PrimaryKeyBase, table=True
):
    __tablename__ = "pricelist_r_logs"

    pricelist_row_id: int = Field(foreign_key="pricelist_r.id", index=True)
    date_updated: datetime = Field(sa_column_kwargs={"server_default": text("now()")})
    updated_by: Optional[int] = Field(default=None, foreign_key="system_user.id")

    updated_by_user: "SystemUser" = Relationship(
        sa_relationship=relationship("SystemUser", lazy=True)
    )
    item: "Item" = Relationship(sa_relationship=relationship("Item", lazy=True))
