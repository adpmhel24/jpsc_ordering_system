from typing import List, Optional
from pydantic import condecimal
from sqlmodel import Field, Relationship
from sqlalchemy.orm import relationship


from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase
from my_app.shared.custom_enums import DocstatusEnum, ObjectTypesEnum, LineStatusEnum


from .schemas_header import InvTrfrHeaderBase
from .schemas_row import InvTrfrRowBase


class InvTrfrHeader(
    UpdatedBase, CreatedBase, InvTrfrHeaderBase, PrimaryKeyBase, table=True
):
    __tablename__ = "inv_trfr_h"
    reference: str = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(default=DocstatusEnum.open, index=True)
    objtype: int = Field(
        default=ObjectTypesEnum.inv_transfer,
        foreign_key="object_type.id",
        index=True,
    )
    rows: List["InvTrfrRow"] = Relationship(
        sa_relationship=relationship("InvTrfrRow", back_populates="header")
    )


class InvTrfrRow(UpdatedBase, CreatedBase, InvTrfrRowBase, PrimaryKeyBase, table=True):
    __tablename__ = "inv_trfr_r"
    doc_id: int = Field(
        foreign_key="inv_trfr_h.id",
        fk_kwargs={"ondelete": "CASCADE"},
        description="Header id",
    )
    linestatus: str = Field(default=LineStatusEnum.open, index=True)
    objtype: int = Field(
        default=ObjectTypesEnum.inv_transfer,
        foreign_key="object_type.id",
        index=True,
    )
    header: "InvTrfrHeader" = Relationship(
        sa_relationship=relationship(
            "InvTrfrHeader",
            back_populates="rows",
        )
    )
    balance: condecimal(max_digits=20, decimal_places=2) = Field(
        default=0, description="Initial will be same as quantity"
    )
    inv_qty: condecimal(max_digits=20, decimal_places=2) = Field(
        default=0,
        description="This field will be the inventry quantity.",
    )
