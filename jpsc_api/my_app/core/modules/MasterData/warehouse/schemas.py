from typing import Optional

from sqlmodel import Relationship, SQLModel, Field
from sqlalchemy.orm import relationship
from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase


class WarehouseBase(SQLModel):
    code: str = Field(primary_key=True, index=True)
    description: Optional[str] = Field(index=True)

    branch_code: str = Field(
        index=True,
        foreign_key="branch.code",
        fk_kwargs={
            "onupdate": "CASCADE",
        },
    )
    is_allowed_negative: Optional[bool] = Field(default=False, index=True)
    # sales_account: Optional[str] = Field(
    #     foreign_key="gl_account.name",
    #     fk_kwargs={"onupdate": "CASCADE"},
    #     index=True,
    #     description="Specify an account in which the income incurred by sales are posted.",
    # )
    # inventory_account: Optional[str] = Field(
    #     foreign_key="gl_account.name",
    #     fk_kwargs={"onupdate": "CASCADE"},
    #     index=True,
    #     description="Reflects the inventory final value and recorded in every inventory transaction that involves items of this warehouse.",
    # )
    # cogs_account: Optional[str] = Field(
    #     foreign_key="gl_account.name",
    #     fk_kwargs={"onupdate": "CASCADE"},
    #     index=True,
    #     title="Cost Of Goods Sold",
    #     description="Account to be used when transactions of selling goods are created. (Item Cost)",
    # )


class OtherField(SQLModel):
    is_active: Optional[bool] = Field(default=True, index=True)


class WarehouseCreate(WarehouseBase):
    pass


class WarehouseUpdate(WarehouseBase):
    pass


class WarehouseRead(UpdatedBase, CreatedBase, OtherField, WarehouseBase):
    branch: Optional["BranchRead"]


from ..branch.schemas import BranchRead

WarehouseRead.update_forward_refs()
