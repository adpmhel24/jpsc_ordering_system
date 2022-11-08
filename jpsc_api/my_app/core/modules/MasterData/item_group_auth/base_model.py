from sqlmodel import SQLModel, Field, text


class ItemGroupUserAuthBase(SQLModel):
    system_user_id: int = Field(
        foreign_key="system_user.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    item_group_code: str = Field(
        foreign_key="item_group.code", fk_kwargs={"onupdate": "CASCADE"}, index=True
    )
    grant_last_purc: bool = Field(
        description="If this is true, user allowed to view last purchased price",
        sa_column_kwargs={"server_default": text("false")},
    )
    grant_avg_value: bool = Field(
        description="If this is true, user allowed to view sap average value",
        sa_column_kwargs={"server_default": text("false")},
    )
