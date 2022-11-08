from typing import List, Optional
from .models import PricelistHeaderBase


class PricelistHeaderCreate(PricelistHeaderBase):
    pass


class PricelistHeaderRead(PricelistHeaderBase):
    rows: List["PricelistRowRead"]


class PricelistHeaderUpdate(PricelistHeaderBase):
    pass


from .schemas_row import PricelistRowRead

PricelistHeaderRead.update_forward_refs()
