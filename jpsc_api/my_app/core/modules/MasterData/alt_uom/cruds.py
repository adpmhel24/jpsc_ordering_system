from typing import List, Optional
from sqlmodel import Session

from my_app.shared.crud import CRUDBase
from my_app.shared.utils import BaseQuery
from .models import AltUom
from .schemas import AltUomCreate, AltUomRead, AltUomUpdate


class CRUDAltUom(CRUDBase[AltUom, AltUomCreate, AltUomRead, AltUomUpdate]):
    def filterBy(self, *, filters: Optional[dict], columns: Optional[List[str]] = None):
        db_obj = BaseQuery.create_query_select(
            model=self.model, filters=filters, columns=columns
        )
        return db_obj


crud_altuom = CRUDAltUom(AltUom)
