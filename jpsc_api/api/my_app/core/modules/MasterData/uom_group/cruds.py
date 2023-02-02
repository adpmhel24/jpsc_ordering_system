from fastapi import HTTPException, status
from typing import Any, Dict, List, Optional, Union
from sqlmodel import func
from sqlalchemy.exc import SQLAlchemyError
from fastapi_sqlalchemy import db

from my_app.shared.crud import CRUDBase
from ..alt_uom.schemas import AltUomCreate
from ..alt_uom.models import AltUom
from .schemas import UomGroupCreate, UomGroupRead, UomGroupUpdate
from .models import UomGroup


class CRUDUomGrp(
    CRUDBase[
        UomGroup,
        UomGroupCreate,
        UomGroupUpdate,
        UomGroupRead,
    ]
):
    def create(
        self,
        *,
        uom_grp_schema: UomGroupCreate,
        alt_uoms_schema: Optional[List[AltUomCreate]],
        user_id: int,
    ) -> Any:

        try:
            # Check if uom code was passed is already exist
            uom_grp_obj = (
                db.session.query(self.model)
                .filter(func.lower(self.model.code) == uom_grp_schema.code.lower())
                .first()
            )
            if uom_grp_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="UoM group code already exist.",
                )

            # create schema model to dict
            c_dict = uom_grp_schema.dict()

            db_obj = self.model(**c_dict)
            db_obj.created_by = user_id

            alt_uom_in_obj = AltUomCreate(
                base_qty=db_obj.base_qty,
                base_uom=db_obj.base_uom,
                alt_qty=db_obj.base_qty,
                alt_uom=db_obj.base_uom,
            )

            alt_uoms_schema.append(alt_uom_in_obj)

            if alt_uoms_schema:
                # Loop the alt_uoms
                for alt_uom_schema in alt_uoms_schema:
                    # Check if the base uom passed is equal to the base uom of uom group
                    if alt_uom_schema.base_uom != db_obj.base_uom:
                        raise HTTPException(
                            status_code=status.HTTP_400_BAD_REQUEST,
                            detail="Invalid base uom, must be equal to uom group base uom.",
                        )

                    alt_uom_obj = AltUom(**alt_uom_schema.dict())
                    alt_uom_obj.created_by = user_id
                    db_obj.alt_uoms.append(alt_uom_obj)

            db.session.add(db_obj)
            db.session.commit()
            db.session.refresh(db_obj)
            return db_obj
        except SQLAlchemyError as err:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=err)

    def get_all(
        self,
        *,
        is_active: bool = True,
    ) -> Any:
        db_obj = (
            db.session.query(self.model)
            .filter(self.model.is_active.is_(is_active))
            .order_by(self.model.code)
            .all()
        )
        return db_obj

    def update(
        self,
        fk: str,
        *,
        update_schema: Union[UomGroupUpdate, Dict[str, Any]],
    ) -> Any:

        # Get the obj.
        db_obj = self.get(fk=fk)

        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND, detail="Invalid uom code."
            )
        if isinstance(update_schema, dict):
            update_data = update_schema
        else:
            update_data = update_schema.dict(exclude_unset=True)

        return super().update(db_obj=db_obj, obj_in=update_data)


crud_uom_grp = CRUDUomGrp(UomGroup)
