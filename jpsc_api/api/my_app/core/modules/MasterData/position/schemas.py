from typing import TYPE_CHECKING, Optional
from sqlmodel import SQLModel, Field


class PositionBase(SQLModel):

    code: str = Field(primary_key=True, index=True,
                      sa_column_kwargs={"unique": True})
    description: Optional[str] = Field(index=True)


class PositionCreate(PositionBase):
    """Create Schema"""

    pass


class PositionUpdate(PositionBase):
    pass


class PositionRead(PositionBase):
    """Read Schema"""

    pass
