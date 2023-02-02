from typing import Optional
from pydantic import condecimal
from sqlmodel import SQLModel, Field

from my_app.shared.schemas.base_schemas import CreatedBase, PrimaryKeyBase, UpdatedBase


class InvTrfrReqRowBase(SQLModel):
    item_code: str = Field(foreign_key="item.code", fk_kwargs={"onupdate": "CASCADE"})
    item_description: Optional[str] = Field(index=True)
    whsecode: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="From Warehouse",
    )
    whsecode2: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
        description="To Warehouse",
    )
    quantity: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    uom: str = Field(foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"})


class InvTrfrReqRowCreate(InvTrfrReqRowBase):
    pass


class InvTrfrReqRowRead(UpdatedBase, CreatedBase, InvTrfrReqRowBase, PrimaryKeyBase):
    doc_id: int
    linestatus: Optional[str]
    balance: condecimal(max_digits=20, decimal_places=2) = Field(
        default=0, description="Initial will be same as quantity"
    )


class InvTrfrReqRowUpdate(InvTrfrReqRowBase):
    linestatus: Optional[str]
