from datetime import datetime
from typing import Optional
from pydantic import condecimal
from sqlmodel import SQLModel, Field, text

from my_app.shared.custom_enums import ObjectTypesEnum


class InvTransactionBase(SQLModel):
    objtype: int = Field(
        default=ObjectTypesEnum.inv_adjustment_out,
        foreign_key="object_type.id",
        index=True,
    )
    base_id: int = Field(index=True)
    row_id: int = Field(index=True)
    transdate: datetime = Field(
        index=True, sa_column_kwargs={"server_default": text("now()")}
    )
    item_code: str = Field(
        foreign_key="item.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )
    inqty: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    outqty: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    uom: str = Field(foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"})
    whsecode: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )
    whsecode2: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )
    is_canceled: bool = Field(sa_column_kwargs={"server_default": text("false")})


class InvTransactionCreate(InvTransactionBase):
    pass


class InvTransactionRead(InvTransactionBase):
    pass


class InvTransactionUpdate(InvTransactionBase):
    pass
