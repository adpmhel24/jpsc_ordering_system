from typing import Optional
from datetime import datetime
from fastapi import HTTPException, status
from fastapi.encoders import jsonable_encoder
from sqlmodel import and_
from my_app.shared.crud.crud_base import CRUDBase
from .models import AppVersion
from .schemas import AppVersionCreate, AppVersionRead, AppVersionUpdate
from ..system_user.schemas import SystemUserRead
from fastapi_sqlalchemy import db

from my_app import gcp_bucket_name, gcp_storage


class CrudAppVersion(
    CRUDBase[AppVersion, AppVersionCreate, AppVersionUpdate, AppVersionRead]
):
    async def create(
        self,
        *,
        platform: str,
        app_name: str,
        package_name: str,
        version: str,
        build_number: str,
        is_active: bool,
        file,
        current_user: SystemUserRead,
    ):

        exist_obj = db.session.query(self.model).filter(
            self.model.platform == platform,
            self.model.app_name == app_name,
            self.model.package_name == package_name,
            self.model.version == version,
            self.model.build_number == build_number,
        )

        if exist_obj.first():
            raise HTTPException(
                status_code=status.HTTP_400_BAD_REQUEST,
                detail="App version already exist.",
            )

        bucket = gcp_storage.get_bucket(gcp_bucket_name)
        blob = bucket.blob(f"{platform}/{version}.{build_number}/{file.filename}")

        blob.upload_from_string(await file.read(), content_type=file.content_type)

        # Make the blob public. This is not necessary if the
        # entire bucket is public.
        # See https://cloud.google.com/storage/docs/access-control/making-data-public.
        blob.make_public()

        if is_active:
            list_of_existing_obj_active = (
                db.session.query(self.model)
                .filter(
                    and_(
                        self.model.platform == platform,
                        self.model.app_name == app_name,
                        self.model.package_name == package_name,
                        self.model.is_active.is_(True),
                    )
                )
                .all()
            )
            if list_of_existing_obj_active:
                for obj in list_of_existing_obj_active:
                    obj.is_active = False
                    db.session.add(obj)

        db_obj = self.model(
            platform=platform,
            app_name=app_name,
            package_name=package_name,
            version=version,
            build_number=build_number,
            is_active=is_active,
            link=blob.public_url,
        )
        db_obj.created_by = current_user.id
        db_obj.date_created = datetime.now()
        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)

        return db_obj

    def get_all(self):
        db_objs = db.session.query(self.model).order_by(self.model.id).all()

        return db_objs

    def get_active_version(self, *, params_dict: Optional[dict]):
        params_list = []
        for k, v in params_dict.items():
            params_list.append(getattr(self.model, k) == v)

        result_obj = (
            db.session.query(self.model)
            .filter(and_(*params_list))
            .order_by(self.model.id.desc())
            .first()
        )

        return result_obj

    def update(
        self, *, fk: int, schema: AppVersionUpdate, current_user: SystemUserRead
    ):
        db_obj = self.get(fk)
        if not db_obj:
            raise HTTPException(
                status_code=status.HTTP_404_NOT_FOUND,
                detail="Invalid fk.",
            )
        schema_dict = schema.dict()
        db_obj_data = jsonable_encoder(db_obj)
        for field in db_obj_data:
            if field in schema_dict:
                setattr(db_obj, field, schema_dict[field])

        db.session.add(db_obj)
        db.session.commit()
        db.session.refresh(db_obj)
        return db_obj


crud_app_version = CrudAppVersion(AppVersion)
