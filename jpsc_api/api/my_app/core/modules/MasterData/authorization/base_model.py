from sqlmodel import SQLModel, Field, text


class AuthorizationBase(SQLModel):
    system_user_id: int = Field(
        foreign_key="system_user.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    objtype: int = Field(
        foreign_key="object_type.id", fk_kwargs={"ondelete": "CASCADE"}, index=True
    )
    full: bool = Field(sa_column_kwargs={"server_default": text("false")}, index=True)
    read: bool = Field(sa_column_kwargs={"server_default": text("false")}, index=True)
    create: bool = Field(sa_column_kwargs={"server_default": text("false")}, index=True)
    approve: bool = Field(
        sa_column_kwargs={"server_default": text("false")}, index=True
    )
    update: bool = Field(sa_column_kwargs={"server_default": text("false")}, index=True)
