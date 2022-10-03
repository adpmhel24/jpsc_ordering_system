from sqlmodel import SQLModel, Field
from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
)


class SalesOrderCommentBase(SQLModel):
    doc_id: int = Field(
        foreign_key="sales_order_h.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    comment: str


class SalesOrderCommentCreate(SQLModel):
    comment: str


class SalesOrderCommentRead(CreatedBase, SalesOrderCommentBase, PrimaryKeyBase):
    pass
