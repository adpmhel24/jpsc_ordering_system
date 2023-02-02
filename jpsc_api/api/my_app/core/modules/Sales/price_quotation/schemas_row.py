from typing import Optional
from sqlmodel import SQLModel, Field
from pydantic import condecimal

from my_app.shared.schemas.base_schemas import PrimaryKeyBase


class PriceQuotationRowBase(SQLModel):

    item_code: str = Field(
        foreign_key="item.code", index=True, fk_kwargs={"onupdated": "CASCADE"}
    )
    item_description: Optional[str]
    quantity: condecimal(max_digits=20, decimal_places=2) = Field(default=0.00)
    srp_price: condecimal(max_digits=20, decimal_places=2) = Field(default=0.00)
    unit_price: condecimal(max_digits=20, decimal_places=2) = Field(default=0.00)
    uom: str = Field(
        foreign_key="uom.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )


class PriceQuotationRowDbModel(PriceQuotationRowBase, PrimaryKeyBase):

    doc_id: int = Field(
        foreign_key="price_quotation_h.id", index=True, fk_kwargs={"ondelete": "CASCADE"}
    )
    linetotal: condecimal(max_digits=20, decimal_places=2) = Field(default=0.00)


class PriceQuotationRowCreate(PriceQuotationRowBase):
    pass


class PriceQuotationRowRead(PriceQuotationRowDbModel):
    pass
