from typing import List, Optional
from pydantic import condecimal
from sqlalchemy.orm import relationship
from sqlmodel import Field, Relationship

from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
    UpdatedBase,
    CanceledBase,
)
from my_app.shared.custom_enums import LineStatusEnum, ObjectTypesEnum, DocstatusEnum

from my_app.core.modules.Inventory.inv_adjustment_in.schemas_header import (
    InvAdjustmentInHeaderBase,
)
from my_app.core.modules.Inventory.inv_adjustment_in.schemas_row import (
    InvAdjustmentInRowBase,
)
from my_app.core.modules.MasterData.object_type.models import ObjectType


class InvAdjustmentInHeader(
    UpdatedBase,
    CreatedBase,
    CanceledBase,
    InvAdjustmentInHeaderBase,
    PrimaryKeyBase,
    table=True,
):
    __tablename__ = "inv_adj_in_h"
    reference: Optional[str] = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(
        default=DocstatusEnum.closed,
    )
    objtype: int = Field(
        default=ObjectTypesEnum.inv_adjustment_in,
        foreign_key=ObjectType.id,
        index=True,
    )
    rows: List["InvAdjustmentInRow"] = Relationship(
        sa_relationship=relationship(
            "InvAdjustmentInRow",
            passive_deletes="all",
            passive_updates=False,
            back_populates="header",
        )
    )
    created_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == InvAdjustmentInHeader.created_by",
            lazy=True,
        )
    )
    updated_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == InvAdjustmentInHeader.updated_by",
            lazy=True,
        )
    )
    canceled_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == InvAdjustmentInHeader.canceled_by",
            lazy=True,
        )
    )


class InvAdjustmentInRow(InvAdjustmentInRowBase, PrimaryKeyBase, table=True):
    __tablename__ = "inv_adj_in_r"
    objtype: int = Field(
        default=ObjectTypesEnum.inv_adjustment_in,
        foreign_key=ObjectType.id,
        index=True,
    )
    linestatus: str = Field(default=LineStatusEnum.open, index=False)
    doc_id: int = Field(
        foreign_key="inv_adj_in_h.id",
        fk_kwargs={"ondelete": "CASCADE"},
        index=True,
        description="Adjustment In Id",
    )
    price: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    header: "InvAdjustmentInHeader" = Relationship(
        sa_relationship=relationship("InvAdjustmentInHeader", back_populates="rows")
    )
    inv_qty: condecimal(max_digits=20, decimal_places=2)
