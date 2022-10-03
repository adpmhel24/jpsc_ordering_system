from typing import Optional
from sqlmodel import SQLModel, Field
from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
)
from pydantic import AnyHttpUrl


class SalesOrderAttachmentBase(SQLModel):
    doc_id: int = Field(
        foreign_key="sales_order_h.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    image_url: AnyHttpUrl


class SalesOrderAttachmentCreate(SQLModel):
    files: str


class SalesOrderAttachmentRead(CreatedBase, SalesOrderAttachmentBase, PrimaryKeyBase):
    pass
