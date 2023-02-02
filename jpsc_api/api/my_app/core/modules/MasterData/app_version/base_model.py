from sqlmodel import SQLModel, Field, text


class AppVersionBaseModel(SQLModel):
    platform: str = Field(index=True)
    app_name: str = Field(index=True)
    package_name: str = Field(index=True)
    version: str = Field(index=True)
    build_number: int = Field(index=True)


class AdditionaColumn(SQLModel):
    is_active: bool = Field(sa_column_kwargs={"server_default": text("false")})
    link: str = Field(index=True)
