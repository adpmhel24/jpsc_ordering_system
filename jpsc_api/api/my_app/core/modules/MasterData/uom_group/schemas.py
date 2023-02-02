from typing import TYPE_CHECKING, List, Optional
from pydantic import condecimal
from sqlmodel import Relationship, SQLModel, Field
from sqlalchemy.orm import relationship

from my_app.shared.schemas.base_schemas import UpdatedBase, CreatedBase


class UomGroupBase(SQLModel):
    code: str = Field(primary_key=True, index=True)
    description: Optional[str] = Field(index=True)
    base_uom: str = Field(
        foreign_key="uom.code",
        fk_kwargs={
            "onupdate": "CASCADE",
        },
    )
    base_qty: condecimal(max_digits=20, decimal_places=2) = Field(default=1)
    is_active: Optional[bool] = Field(default=True)


class UomGroupCreate(UomGroupBase):
    pass


class UomGroupUpdate(UomGroupBase):
    pass


class UomGroupRead(UpdatedBase, CreatedBase, UomGroupBase):
    alt_uoms: List["AltUomRead"]


from ..alt_uom.schemas import AltUomRead

UomGroupRead.update_forward_refs()
