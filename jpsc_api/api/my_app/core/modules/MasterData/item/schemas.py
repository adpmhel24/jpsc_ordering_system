from typing import Optional
from decimal import Decimal
from sqlmodel import Field, SQLModel
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class ItemBase(SQLModel):
    code: str = Field(primary_key=True, index=True)
    description: Optional[str] = Field(index=True)
    item_group_code: Optional[str] = Field(foreign_key="item_group.code", index=True)
    sale_uom_code: Optional[str] = Field(foreign_key="uom.code", index=True)
    barcode: Optional[str] = Field(index=True, sa_column_kwargs={"unique": True})
    is_allowed_negative: Optional[bool] = Field(default=False)


class OtherField(SQLModel):
    is_active: bool = Field(default=True)


class ItemCreate(ItemBase):
    pass


class ItemUpdate(ItemBase):
    pass


class ItemRead(UpdatedBase, CreatedBase, OtherField, ItemBase):
    item_group: Optional["ItemGroupRead"]
    sale_uom: Optional["UoMRead"]
    price: Optional[Decimal]


from ..item_group.schemas import ItemGroupRead
from ..uom.schemas import UoMRead


ItemRead.update_forward_refs()
