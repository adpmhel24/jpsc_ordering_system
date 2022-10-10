from sqlmodel import SQLModel, Field
from my_app.shared.schemas.base_schemas import (
    PrimaryKeyBase,
    CreatedBase,
)


class PriceQuotationCommentBase(SQLModel):
    doc_id: int = Field(
        foreign_key="price_quotation_h.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    comment: str


class PriceQuotationCommentCreate(SQLModel):
    comment: str


class PriceQuotationCommentRead(CreatedBase, PriceQuotationCommentBase, PrimaryKeyBase):
    pass
