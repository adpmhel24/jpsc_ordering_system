from typing import Optional
from sqlmodel import SQLModel, Field


class UoMBase(SQLModel):
    code: str = Field(primary_key=True, index=True)
    description: Optional[str] = Field(index=True)
    is_active: Optional[bool] = Field(default=True)


class UoMCreate(UoMBase):
    pass


class UoMUpdate(UoMBase):
    pass


class UoMRead(UoMBase):
    pass
