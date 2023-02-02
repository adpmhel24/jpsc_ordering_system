from operator import or_
from fastapi import HTTPException, Query, status
from typing import Any, Dict, List, Optional, Union
from sqlalchemy.exc import SQLAlchemyError
from sqlmodel import or_, func
from fastapi_sqlalchemy import db

from my_app.shared.crud import CRUDBase
from ..branch import Branch
from .models import Warehouse
from .schemas import WarehouseCreate, WarehouseRead, WarehouseUpdate


class CRUDWarehouse(
    CRUDBase[
        Warehouse,
        WarehouseCreate,
        WarehouseUpdate,
        WarehouseRead,
    ]
):
    def create(
        self,
        *,
        create_schema: WarehouseCreate,
        user_id: int,
    ) -> Any:

        try:
            # Check if warehouse code was passed is already exist
            warehouse_obj = (
                db.session.query(self.model)
                .filter(func.lower(self.model.code) == create_schema.code.lower())
                .first()
            )
            if warehouse_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Warehouse code already exist.",
                )
            # create create_schema model to dict
            c_dict = create_schema.dict()

            # pop the branch code
            # Check if branch code is valid
            branch_obj = db.session.query(Branch).get(create_schema.branch_code)
            if not branch_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Invalid branch code.",
                )
            db_obj = Warehouse(**c_dict)
            db_obj.created_by = user_id
            branch_obj.warehouses.append(db_obj)
            db.session.add(db_obj)
            db.session.commit()
            db.session.refresh(db_obj)
            return db_obj

        except SQLAlchemyError as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))

    def get_all(
        self,
        *,
        is_active: Optional[bool] = Query(None),
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(or_(is_active == None, self.model.is_active.is_(is_active)))
            .order_by(self.model.code)
        ).all()
        return db_obj

    def update(
        self,
        fk: str,
        *,
        update_schema: Union[WarehouseUpdate, Dict[str, Any]],
    ) -> Any:
        db_obj = self.get(db=db, fk=fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid warehouse code."
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)
        return super().update(db_obj=db_obj, obj_in=update_data)


crud_whse = CRUDWarehouse(Warehouse)
