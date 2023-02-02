from typing import Optional
from pydantic import condecimal
from sqlmodel import SQLModel, Field


from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase


class InvReceiveRowBase(SQLModel):
    base_id: Optional[int] = Field(description="Base header id")
    base_objtype: Optional[int] = Field(
        foreign_key="object_type.id",
        description="Base header object type",
    )
    base_row_id: Optional[int] = Field(description="Base row id")
    base_qty: Optional[condecimal(max_digits=20, decimal_places=2)] = Field(
        default=0,
        description="Base Quantity",
    )
    item_code: str = Field(foreign_key="item.code",
                           fk_kwargs={"onupdate": "CASCADE"})
    item_description: Optional[str] = Field(index=True)
    quantity: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    whsecode: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="To Warehouse",
    )
    whsecode2: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="From Warehouse",
    )
    uom: str = Field(foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"})


class InvReceiveRowCreate(InvReceiveRowBase):
    pass


class InvReceiveRowRead(UpdatedBase, CreatedBase, InvReceiveRowBase, PrimaryKeyBase):
    doc_id: int
    linestatus: str


class InvReceiveRowUpdate(InvReceiveRowBase):
    linestatus: Optional[str]
