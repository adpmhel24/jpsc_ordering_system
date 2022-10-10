from typing import List
from sqlmodel import Relationship, Field
from sqlalchemy.orm import relationship
from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
    UpdatedBase,
    CanceledBase,
    ApprovedBase,
)


from .schemas_header import PriceQuotationHeaderBase, PriceQuotationHeaderAddCol
from .schemas_row import PriceQuotationRowDbModel
from .schemas_pq_attachment import PriceQuotationAttachmentBase
from .schemas_pq_comment import PriceQuotationCommentBase


class PriceQuotationHeader(
    CanceledBase,
    ApprovedBase,
    UpdatedBase,
    CreatedBase,
    PriceQuotationHeaderAddCol,
    PriceQuotationHeaderBase,
    PrimaryKeyBase,
    table=True,
):
    __tablename__ = "price_quotation_h"

    rows: List["PriceQuotationRow"] = Relationship(back_populates="header")
    comments: List["PriceQuotationComment"] = Relationship(back_populates="header")

    created_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == PriceQuotationHeader.created_by",
            lazy=True,
        )
    )
    updated_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == PriceQuotationHeader.updated_by",
            lazy=True,
        )
    )
    approved_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == PriceQuotationHeader.approved_by",
            lazy=True,
        )
    )
    canceled_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == PriceQuotationHeader.canceled_by",
            lazy=True,
        )
    )

    confirmed_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == PriceQuotationHeader.confirmed_by",
            lazy=True,
        )
    )

    dispatched_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == PriceQuotationHeader.dispatched_by",
            lazy=True,
        )
    )


class PriceQuotationRow(PriceQuotationRowDbModel, table=True):
    __tablename__ = "price_quotation_r"

    header: "PriceQuotationHeader" = Relationship(back_populates="rows")


class PriceQuotationComment(
    CreatedBase, PriceQuotationCommentBase, PrimaryKeyBase, table=True
):
    __tablename__ = "price_quotation_comment"
    header: "PriceQuotationHeader" = Relationship(back_populates="comments")


class PriceQuotationAttachment(
    CreatedBase, PriceQuotationAttachmentBase, PrimaryKeyBase, table=True
):
    __tablename__ = "price_quotation_attachment"
