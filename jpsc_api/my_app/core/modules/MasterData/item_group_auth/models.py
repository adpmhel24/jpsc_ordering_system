from sqlmodel import Field
from my_app.shared.schemas.base_schemas import PrimaryKeyBase, UpdatedBase
from .base_model import ItemGroupUserAuthBase


class ItemGroupUserAuth(UpdatedBase, ItemGroupUserAuthBase, PrimaryKeyBase, table=True):
    __tablename__ = "auth_item_group"
    pass


class ItemGroupUserAuthLogs(UpdatedBase, ItemGroupUserAuthBase, table=True):
    __tablename__ = "logs_auth_item_group"
    log_id: int = Field(
        primary_key=True,
        index=True,
        sa_column_kwargs={"autoincrement": True, "unique": True},
    )
    item_group_auth_id: int = Field(
        foreign_key="auth_item_group.id", fk_kwargs={"ondelete": "RESTRICT"}, index=True
    )
