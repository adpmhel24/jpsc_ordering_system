from typing import Optional
from sqlmodel import SQLModel, Field

from my_app.shared.schemas.base_schemas import CreatedBase, UpdatedBase, PrimaryKeyBase
from .schemas import CustomerTypeBase


class CustomerType(UpdatedBase, CreatedBase, CustomerTypeBase, table=True):
    __tablename__ = "customertype"
