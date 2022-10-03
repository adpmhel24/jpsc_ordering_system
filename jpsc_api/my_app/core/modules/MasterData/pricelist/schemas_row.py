from typing import Optional
from sqlmodel import SQLModel, Field, text
from pydantic import condecimal


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
    uom_code: Optional[str] = Field(
        foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"}
    )


class PricelistRowRead(PricelistRowBase):
    id: int


class PricelistRowUpdate(PricelistRowBase):
    id: int
