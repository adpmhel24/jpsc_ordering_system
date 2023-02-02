from datetime import datetime
from fastapi import HTTPException, status
from typing import Any, List
from sqlmodel import func, and_
from sqlalchemy.exc import SQLAlchemyError
from fastapi_sqlalchemy import db
import httpx
from fastapi.encoders import jsonable_encoder

from my_app.core.modules.MasterData.item.models import Item
from my_app.core.modules.MasterData.system_user.models import SystemUser
from my_app.core.modules.MasterData.system_user.schemas import SystemUserRead
from my_app.shared.crud import CRUDBase
from ....settings.config import settings


from .schemas_header import (
    PricelistHeaderCreate,
    PricelistHeaderRead,
    PricelistHeaderUpdate,
)
from .schemas_row import PricelistRowUpdate
from .models import PricelistHeader, PricelistRow, PricelistRowLogs
from ..branch import models


class CRUDPricelist(
    CRUDBase[
        PricelistHeader,
        PricelistHeaderCreate,
        PricelistHeaderUpdate,
        PricelistHeaderRead,
    ]
):
    def create(self, *, create_schema: PricelistHeaderCreate, user_id: int):
        try:

            header_obj = (
                db.session.query(self.model)
                .filter(func.lower(self.model.code) == create_schema.code.lower())
                .first()
            )
            if header_obj:
                raise HTTPException(
                    status_code=status.HTTP_400_BAD_REQUEST,
                    detail="Pricelist code already exist.",
                )

            db_obj = self.model(**create_schema.dict())
            db_obj.created_by = user_id

            db.session.add(db_obj)
            db.session.commit()
            db.session.refresh(db_obj)
            return db_obj

        except SQLAlchemyError as e:
            raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail=str(e))

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

    def udpate_pricelist_header(
        self,
        *,
        fk: str,
        data_dict: dict,
        current_user: SystemUser,
    ):
        db_obj = db.session.query(self.model).get(fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Pricelist code not found.",
            )
        obj_data = jsonable_encoder(db_obj)
        for field in obj_data:
            if field in data_dict:
                if data_dict[field] != getattr(db_obj, field):
                    setattr(db_obj, field, data_dict[field])
                    db_obj.updated_by = current_user.id
                    db_obj.date_updated = datetime.now()

        db.session.commit()
        return "Updated successfully."

    async def getPricelistRowByPricelistCode(
        self,
        *,
        fk: str,
    ) -> Any:
        async with httpx.AsyncClient() as client:
            # Fetch the last purchase price
            resp = await client.get(f"{settings.SAP_API_URI}/products/lastPurchPrc")
            resp.raise_for_status()
            data_results_dict = resp.json()["data"]  # serialize the result
            if data_results_dict:  # if not empty, iterate
                for result_dict in data_results_dict:
                    # Query the pricelist row and filter it by result itemCode
                    pricelist_rows_obj = db.session.query(PricelistRow).filter(
                        PricelistRow.item_code == result_dict["ItemCode"],
                        PricelistRow.pricelist_code == fk,
                    )
                    if pricelist_rows_obj:  # if not empty, iterate
                        for pricelist_row_obj in pricelist_rows_obj:
                            # check if the last_puchase_price is not equal to the result lastPurcPrc
                            # then update
                            if (
                                pricelist_row_obj.last_purchase_price
                                != result_dict["LastPurPrc"]
                                and result_dict["AvgValue"]
                            ):
                                pricelist_row_obj.last_purchase_price = result_dict[
                                    "LastPurPrc"
                                ]
                                pricelist_row_obj.avg_sap_value = result_dict[
                                    "AvgValue"
                                ]

                db.session.commit()

        db_obj = db.session.query(self.model).filter(self.model.code == fk).first()
        return db_obj

    async def get_pricelist_r_by_item_code(
        self,
        *,
        item_code: str,
    ) -> Any:
        async with httpx.AsyncClient() as client:
            # Fetch the last purchase price
            resp = await client.get(f"{settings.SAP_API_URI}/products/lastPurchPrc")
            resp.raise_for_status()
            data_results_dict = resp.json()["data"]  # serialize the result
            if data_results_dict:  # if not empty, iterate
                for result_dict in data_results_dict:
                    if result_dict["ItemCode"] == item_code:
                        # Query the pricelist row and filter it by result itemCode

                        pricelist_rows_obj = db.session.query(PricelistRow).filter(
                            PricelistRow.item_code == result_dict["ItemCode"],
                        )
                        if pricelist_rows_obj:  # if not empty, iterate
                            for pricelist_row_obj in pricelist_rows_obj:
                                # check if the last_puchase_price is not equal to the result lastPurcPrc
                                # then update
                                if (
                                    pricelist_row_obj.last_purchase_price
                                    != result_dict["LastPurPrc"]
                                    and result_dict["AvgValue"]
                                ):
                                    pricelist_row_obj.last_purchase_price = result_dict[
                                        "LastPurPrc"
                                    ]
                                    pricelist_row_obj.avg_sap_value = result_dict[
                                        "AvgValue"
                                    ]

                db.session.commit()

        db_obj = (
            db.session.query(PricelistRow)
            .filter(PricelistRow.item_code == item_code)
            .order_by(PricelistRow.pricelist_code)
            .all()
        )
        return db_obj

    def get_pricelist_r_by_branch(
        self,
        *,
        branch_code: str,
    ) -> Any:
        branch_obj = db.session.query(models.Branch).get(branch_code)
        if not branch_obj:
            raise HTTPException(status_code=404, detail="Invalid branch code.")
        pricelist_row_obj = (
            db.session.query(PricelistRow)
            .join(Item, Item.code == PricelistRow.item_code)
            .filter(
                and_(
                    PricelistRow.pricelist_code == branch_obj.pricelist_code,
                    Item.is_active.is_(True),
                )
            )
            .all()
        )
        if not pricelist_row_obj:
            raise HTTPException(
                status_code=404,
                detail=f"{branch_code.capitalize()} has no pricelist assign.",
            )
        return pricelist_row_obj

    def get_pricelist_row_logs(self, *, pricelist_row_id: int) -> Any:
        pricelist_r_log_obj = (
            db.session.query(PricelistRowLogs)
            .filter(PricelistRowLogs.pricelist_row_id == pricelist_row_id)
            .order_by(PricelistRowLogs.date_updated.desc())
            .all()
        )
        return pricelist_r_log_obj

    def update_rows(
        self,
        *,
        pricelistRows: List[PricelistRowUpdate],
        current_user: SystemUserRead,
    ) -> Any:
        list_to_updated = []
        for row_schema in pricelistRows:
            row_schema_dict = row_schema.dict()
            pricelistRow_obj = db.session.query(PricelistRow).get(row_schema.id)
            pricelistRow_obj_data = jsonable_encoder(pricelistRow_obj)
            for field in pricelistRow_obj_data:
                if field in row_schema_dict:
                    if getattr(pricelistRow_obj, field) != getattr(row_schema, field):
                        row_schema_dict["updated_by"] = current_user.id
                        row_schema_dict["date_updated"] = datetime.now()
                        list_to_updated.append(row_schema_dict)
                        break

        if list_to_updated:
            db.session.bulk_update_mappings(PricelistRow, list_to_updated)
            db.session.commit()
        return "Updated successfully."


crud_pricelist = CRUDPricelist(model=PricelistHeader)
