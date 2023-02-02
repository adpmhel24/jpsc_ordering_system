from sqlmodel import Field, text
from .base_model import AppVersionBaseModel, AdditionaColumn
from my_app.shared.schemas.base_schemas import PrimaryKeyBase, CreatedBase


class AppVersion(
    CreatedBase, AdditionaColumn, AppVersionBaseModel, PrimaryKeyBase, table=True
):
    __tablename__ = "app_version"
