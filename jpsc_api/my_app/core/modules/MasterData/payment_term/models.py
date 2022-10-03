from sqlmodel import SQLModel, Field
from typing import Optional

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class PaymentTermBase(SQLModel):

    code: str = Field(primary_key=True, index=True, sa_column_kwargs={"unique": True})
    description: Optional[str] = Field(index=True)


class PaymentTerm(CreatedBase, UpdatedBase, PaymentTermBase, table=True):
    """System User Database Model"""

    __tablename__ = "payment_term"
