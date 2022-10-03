from typing import Optional

from sqlmodel import SQLModel, Field, Column, text, BOOLEAN

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class BranchBase(SQLModel):
    code: str = Field(primary_key=True, index=True, sa_column_kwargs={"unique": True})
    description: Optional[str] = Field(default=None, index=True)
    series_code: Optional[str] = Field(index=True, sa_column_kwargs={"unique": True})
    is_active: Optional[bool] = Field(
        sa_column=Column(BOOLEAN, server_default=text("true"))
    )
    pricelist_code: Optional[str] = Field(
        foreign_key="pricelist_h.code", fk_kwargs={"onupdate": "CASCADE"}
    )


class BranchCreate(BranchBase):
    """Create Schema"""

    pass


class BranchUpdate(BranchBase):
    """Update Schema"""

    pass


class BranchRead(UpdatedBase, CreatedBase, BranchBase):
    """Read Schema"""

    pricelist: Optional["PricelistHeaderRead"]


from ..pricelist import PricelistHeaderRead

BranchRead.update_forward_refs()
