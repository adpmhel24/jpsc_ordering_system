from enum import unique
from typing import Optional
from sqlmodel import SQLModel, Field, text

from my_app.shared.schemas.base_schemas import CreatedBase


class MenuGroupBase(SQLModel):
    code: str = Field(primary_key=True, index=True, sa_column_kwargs={"unique": True})
    is_active: Optional[bool] = Field(
        sa_column_kwargs={"server_default": text("true")}, index=True
    )


class MenuGroup(CreatedBase, MenuGroupBase, table=True):

    __tablename__ = "menu_group"
    pass
