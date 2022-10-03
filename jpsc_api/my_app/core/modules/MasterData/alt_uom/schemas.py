from typing import TYPE_CHECKING, Optional
from pydantic import condecimal
from sqlmodel import Relationship, SQLModel, Field


from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase


class AltUomBase(SQLModel):
    uom_group_code: Optional[str] = Field(index=True, foreign_key="uom_group.code")
    alt_qty: condecimal(max_digits=20, decimal_places=2) = Field(default=1)
    alt_uom: str = Field(
        foreign_key="uom.code",
        fk_kwargs={
            "onupdate": "CASCADE",
        },
    )
    base_qty: condecimal(max_digits=20, decimal_places=2) = Field(default=1)
    base_uom: str = Field(
        foreign_key="uom.code",
        fk_kwargs={
            "onupdate": "CASCADE",
        },
    )


class AltUomCreate(AltUomBase):
    pass


class AltUomUpdate(AltUomBase):
    pass


class AltUomRead(UpdatedBase, CreatedBase, AltUomBase, PrimaryKeyBase):
    pass
