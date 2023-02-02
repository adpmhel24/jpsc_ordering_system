from pydantic import condecimal
from sqlmodel import SQLModel, Field


class WhseInvBase(SQLModel):
    item_code: str = Field(
        foreign_key="item.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )
    quantity: condecimal(max_digits=20, decimal_places=2) = Field(default=0)
    whsecode: str = Field(
        foreign_key="warehouse.code",
        fk_kwargs={"onupdate": "CASCADE"},
        index=True,
    )


class WhseInvCreate(WhseInvBase):
    pass


class WhseInvRead(WhseInvBase):
    pass


class WhseInvUpdate(WhseInvBase):
    pass
