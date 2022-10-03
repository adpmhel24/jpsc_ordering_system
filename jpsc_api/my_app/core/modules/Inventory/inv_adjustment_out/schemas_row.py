from typing import Optional
from pydantic import condecimal
from sqlmodel import SQLModel, Field


class InvAdjustmentOutRowBase(SQLModel):
    item_code: str = Field(
        foreign_key="item.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )
    item_description: str = Field(index=True)
    quantity: condecimal(max_digits=20, decimal_places=2)
    whsecode: str = Field(
        foreign_key="warehouse.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )
    whsecode2: Optional[str] = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="Destination Warehous",
    )
    uom: str = Field(foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"})


class InvAdjustmentOutRowCreate(InvAdjustmentOutRowBase):
    pass


class InvAdjustmentOutRowRead(InvAdjustmentOutRowBase):
    id: int
    doc_id: int
    inv_qty: condecimal(max_digits=20, decimal_places=2)


class InvAdjustmentOutRowUpdate(InvAdjustmentOutRowBase):
    pass
