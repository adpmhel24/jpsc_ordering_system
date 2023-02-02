from typing import List
from pydantic import condecimal
from sqlalchemy.orm import relationship
from sqlmodel import Field, Relationship
from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase, UpdatedBase
from my_app.shared.custom_enums import DocstatusEnum, LineStatusEnum, ObjectTypesEnum

from .schemas_header import InvReceiveHeaderBase
from .schemas_row import InvReceiveRowBase


class InvReceiveHeader(
    UpdatedBase, CreatedBase, InvReceiveHeaderBase, PrimaryKeyBase, table=True
):
    __tablename__ = "inv_receive_h"
    reference: str = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(default=DocstatusEnum.open, index=True)
    objtype: int = Field(
        default=ObjectTypesEnum.inv_receive,
        foreign_key="object_type.id",
        index=True,
    )
    rows: List["InvReceiveRow"] = Relationship(
        sa_relationship=relationship("InvReceiveRow", back_populates="header")
    )


class InvReceiveRow(
    UpdatedBase, CreatedBase, InvReceiveRowBase, PrimaryKeyBase, table=True
):
    __tablename__ = "inv_receive_r"
    doc_id: int = Field(
        foreign_key="inv_receive_h.id",
        fk_kwargs={"ondelete": "CASCADE"},
        index=True,
    )
    objtype: int = Field(
        default=ObjectTypesEnum.inv_receive,
        foreign_key="object_type.id",
        index=True,
    )
    linestatus: str = Field(default=LineStatusEnum.open, index=True)
    header: "InvReceiveHeader" = Relationship(
        sa_relationship=relationship(
            "InvReceiveHeader",
            back_populates="rows",
        )
    )
    inv_qty: condecimal(max_digits=20, decimal_places=2) = Field(
        default=0,
        description="This field will be the inventry quantity.",
    )
