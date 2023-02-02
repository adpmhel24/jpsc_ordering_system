from .base_model import AppVersionBaseModel, AdditionaColumn


class AppVersionCreate(AppVersionBaseModel):
    pass


class AppVersionUpdate(AppVersionBaseModel):
    pass


class AppVersionRead(AdditionaColumn, AppVersionBaseModel):
    id: int
