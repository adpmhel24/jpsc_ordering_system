from typing import List, Optional
from pydantic import condecimal
from sqlmodel import Field, Relationship
from sqlalchemy.orm import relationship


from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
    UpdatedBase,
    CanceledBase,
)
from my_app.shared.custom_enums import DocstatusEnum, ObjectTypesEnum, LineStatusEnum


from my_app.core.modules.Inventory.inv_adjustment_out.schemas_header import (
    InvAdjustmentOutHeaderBase,
)
from my_app.core.modules.Inventory.inv_adjustment_out.schemas_row import (
    InvAdjustmentOutRowBase,
)


class InvAdjustmentOutHeader(
    UpdatedBase,
    CreatedBase,
    CanceledBase,
    InvAdjustmentOutHeaderBase,
    PrimaryKeyBase,
    table=True,
):
    __tablename__ = "inv_adj_out_h"
    reference: Optional[str] = Field(index=True, sa_column_kwargs={"unique": True})
    docstatus: str = Field(
        default=DocstatusEnum.closed,
    )
    objtype: int = Field(
        default=ObjectTypesEnum.inv_adjustment_out,
        foreign_key="object_type.id",
        index=True,
    )
    rows: List["InvAdjustmentOutRow"] = Relationship(
        sa_relationship=relationship(
            "InvAdjustmentOutRow",
            back_populates="header",
        )
    )

    created_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == InvAdjustmentOutHeader.created_by",
            lazy=True,
        )
    )
    updated_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == InvAdjustmentOutHeader.updated_by",
            lazy=True,
        )
    )
    canceled_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == InvAdjustmentOutHeader.canceled_by",
            lazy=True,
        )
    )


class InvAdjustmentOutRow(InvAdjustmentOutRowBase, PrimaryKeyBase, table=True):
    __tablename__ = "inv_adj_out_r"
    objtype: int = Field(
        default=ObjectTypesEnum.inv_adjustment_out,
        foreign_key="object_type.id",
        index=True,
    )
    linestatus: str = Field(default=LineStatusEnum.closed, index=False)
    doc_id: int = Field(
        foreign_key="inv_adj_out_h.id",
        fk_kwargs={"ondelete": "CASCADE"},
        index=True,
        description="Adjustment Out Id",
    )
    price: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    header: "InvAdjustmentOutHeader" = Relationship(
        sa_relationship=relationship("InvAdjustmentOutHeader", back_populates="rows")
    )
    inv_qty: condecimal(max_digits=20, decimal_places=2)
