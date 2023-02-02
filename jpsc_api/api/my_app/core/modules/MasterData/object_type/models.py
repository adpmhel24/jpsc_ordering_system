from typing import Optional
from sqlmodel import Field, SQLModel, text


class ObjectTypeBase(SQLModel):

    id: int = Field(
        primary_key=True,
        # sa_column_kwargs={"autoincrement": False, "unique": True},
        index=True,
        nullable=False,
    )
    name: str = Field(index=True, sa_column_kwargs={"unique": True}, nullable=True)
    menu_group_code: Optional[str] = Field(
        foreign_key="menu_group.code", fk_kwargs={"onupdated": "CASCADE"}, index=True
    )

    is_active: Optional[bool] = Field(
        sa_column_kwargs={"server_default": text("true")}, index=True
    )


class ObjectType(ObjectTypeBase, table=True):
    __tablename__ = "object_type"
