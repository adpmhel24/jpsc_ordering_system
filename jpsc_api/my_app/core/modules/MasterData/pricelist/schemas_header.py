from typing import List, Optional
from sqlmodel import SQLModel, Field, text


class PricelistHeaderBase(SQLModel):
    code: str = Field(primary_key=True, sa_column_kwargs={"unique": True}, index=True)
    description: Optional[str]
    is_active: bool = Field(sa_column_kwargs={"server_default": text("true")})


class PricelistHeaderCreate(PricelistHeaderBase):
    pass


class PricelistHeaderRead(PricelistHeaderBase):
    rows: List["PricelistRowRead"]


class PricelistHeaderUpdate(PricelistHeaderBase):
    pass


from .schemas_row import PricelistRowRead

PricelistHeaderRead.update_forward_refs()
