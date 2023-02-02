from typing import Optional
from sqlmodel import SQLModel, Field, text
from pydantic import condecimal

from .models import PricelistRowBase, AdditionalPricelistRowCol


class PricelistRowRead(AdditionalPricelistRowCol, PricelistRowBase):
    id: int
    item: "ItemRead"


class PricelistRowUpdate(PricelistRowBase):
    id: int


class PricelistRowLogsRead(PricelistRowBase, AdditionalPricelistRowCol):
    id: int
    item: "ItemRead"
    updated_by_user: "SystemUserRead"


from ..item.schemas import ItemRead
from ...MasterData.system_user.schemas import SystemUserRead

PricelistRowRead.update_forward_refs()
PricelistRowLogsRead.update_forward_refs()
