from sqlmodel import Field, SQLModel


class ObjectTypeBase(SQLModel):

    id: int = Field(
        primary_key=True,
        # sa_column_kwargs={"autoincrement": False, "unique": True},
        index=True,
        nullable=False,
    )
    name: str = Field(index=True, sa_column_kwargs={"unique": True}, nullable=True)
