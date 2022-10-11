from sqlmodel import SQLModel, Field
from typing import Optional

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class PaymentTermsBase(SQLModel):

    code: str = Field(primary_key=True, index=True, sa_column_kwargs={"unique": True})
    description: Optional[str] = Field(index=True)


class PaymentTerms(CreatedBase, UpdatedBase, PaymentTermsBase, table=True):
    """System User Database Model"""

    __tablename__ = "payment_terms"
