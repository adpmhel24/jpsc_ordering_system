from typing import Optional
from sqlmodel import SQLModel, Field
from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
)
from pydantic import AnyHttpUrl


class PriceQuotationAttachmentBase(SQLModel):
    doc_id: int = Field(
        foreign_key="price_quotation_h.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    image_url: AnyHttpUrl


class PriceQuotationAttachmentCreate(SQLModel):
    files: str


class PriceQuotationAttachmentRead(
    CreatedBase, PriceQuotationAttachmentBase, PrimaryKeyBase
):
    pass
