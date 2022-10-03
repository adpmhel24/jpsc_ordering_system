from typing import List
from sqlmodel import Relationship, Field
from sqlalchemy.orm import relationship
from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
    UpdatedBase,
    CanceledBase,
)


from .schemas_header import SalesOrderHeaderBase, SalesOrderHeaderAddCol
from .schemas_row import SalesOrderRowDbModel
from .schemas_so_attachment import SalesOrderAttachmentBase
from .schemas_so_comment import SalesOrderCommentBase


class SalesOrderHeader(
    CanceledBase,
    UpdatedBase,
    CreatedBase,
    SalesOrderHeaderAddCol,
    SalesOrderHeaderBase,
    PrimaryKeyBase,
    table=True,
):
    __tablename__ = "sales_order_h"

    rows: List["SalesOrderRow"] = Relationship(back_populates="header")
    comments: List["SalesOrderComment"] = Relationship(back_populates="header")

    created_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == SalesOrderHeader.created_by",
            lazy=True,
        )
    )
    updated_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == SalesOrderHeader.updated_by",
            lazy=True,
        )
    )
    canceled_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == SalesOrderHeader.canceled_by",
            lazy=True,
        )
    )

    confirmed_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == SalesOrderHeader.confirmed_by",
            lazy=True,
        )
    )

    dispatched_by_user = Relationship(
        sa_relationship=relationship(
            "SystemUser",
            primaryjoin="SystemUser.id == SalesOrderHeader.dispatched_by",
            lazy=True,
        )
    )


class SalesOrderRow(SalesOrderRowDbModel, table=True):
    __tablename__ = "sales_order_r"

    header: "SalesOrderHeader" = Relationship(back_populates="rows")


class SalesOrderComment(CreatedBase, SalesOrderCommentBase, PrimaryKeyBase, table=True):
    __tablename__ = "sales_order_comment"
    header: "SalesOrderHeader" = Relationship(back_populates="comments")


class SalesOrderAttachment(
    CreatedBase, SalesOrderAttachmentBase, PrimaryKeyBase, table=True
):
    __tablename__ = "sales_order_attachment"
