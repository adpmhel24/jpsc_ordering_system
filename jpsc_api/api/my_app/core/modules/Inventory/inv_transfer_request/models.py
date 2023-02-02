from typing import List
from pydantic import condecimal
from sqlmodel import Relationship, Field
from sqlalchemy.orm import relationship

from my_app.shared.schemas.base_schemas import (
    CanceledBase,
    CreatedBase,
    PrimaryKeyBase,
    UpdatedBase,
)
from my_app.shared.custom_enums import LineStatusEnum, ObjectTypesEnum, DocstatusEnum

from .schemas_header import InvTrfrReqHeaderBase
from .schemas_row import InvTrfrReqRowBase


class InvTrfrReqHeader(
    UpdatedBase,
    CreatedBase,
    CanceledBase,
    InvTrfrReqHeaderBase,
    PrimaryKeyBase,
    table=True,
):
    __tablename__ = "inv_trfr_req_h"
    reference: str = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(default=DocstatusEnum.open, index=True)
    objtype: int = Field(
        default=ObjectTypesEnum.inv_transfer_request,
        foreign_key="object_type.id",
        index=True,
    )
    rows: List["InvTrfrReqRow"] = Relationship(
        sa_relationship=relationship(
            "InvTrfrReqRow",
            passive_deletes="all",
            passive_updates=False,
            back_populates="header",
        )
    )


class InvTrfrReqRow(InvTrfrReqRowBase, PrimaryKeyBase, table=True):
    __tablename__ = "inv_trfr_req_r"

    doc_id: int = Field(
        foreign_key="inv_trfr_req_h.id",
        fk_kwargs={"ondelete": "CASCADE"},
        description="Header id",
    )
    objtype: int = Field(
        default=ObjectTypesEnum.inv_transfer_request,
        foreign_key="object_type.id",
        index=True,
    )
    linestatus: str = Field(default=LineStatusEnum.open, index=True)
    header: "InvTrfrReqHeader" = Relationship(
        sa_relationship=relationship(
            "InvTrfrReqHeader",
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
