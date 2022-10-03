from typing import Optional
from sqlmodel import SQLModel, Field

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase, PrimaryKeyBase


class CustomerTypeBase(SQLModel):

    code: str = Field(primary_key=True, index=True, sa_column_kwargs={"unique": True})
    description: Optional[str] = Field(default=None, index=True)


class CustomerTypeRead(CustomerTypeBase):
    pass
