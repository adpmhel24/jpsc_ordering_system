from typing import Optional
from pydantic import condecimal
from sqlmodel import SQLModel, Field

from my_app.core.modules.MasterData.warehouse.cruds import crud_whse
from my_app.core.modules.MasterData.item.cruds import crud_item
from my_app.core.modules.MasterData.alt_uom.cruds import crud_altuom


class InvAdjustmentInRowBase(SQLModel):
    item_code: str = Field(
        foreign_key="item.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )
    item_description: str = Field(index=True)
    whsecode: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="Destination Warehous",
    )
    whsecode2: Optional[str] = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="Destination Warehous",
    )
    quantity: condecimal(max_digits=20, decimal_places=2)
    uom: str = Field(foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"})


class InvAdjustmentInRowCreate(InvAdjustmentInRowBase):
    pass


class InvAdjustmentInRowRead(InvAdjustmentInRowBase):
    id: int
    doc_id: int
    inv_qty: condecimal(max_digits=20, decimal_places=2)


class InvAdjustmentInRowUpdate(InvAdjustmentInRowBase):
    pass
