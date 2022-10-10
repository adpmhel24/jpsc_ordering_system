from typing import Optional
from sqlmodel import SQLModel, Field, TIMESTAMP, Column, text
from datetime import datetime


class PrimaryKeyBase(SQLModel):
    id: int = Field(primary_key=True, index=True)


class CreatedBase(SQLModel):
    date_created: Optional[datetime] = Field(
        sa_column_kwargs={"server_default": text("now()")}
    )
    created_by: Optional[int] = Field(default=None, foreign_key="system_user.id")


class UpdatedBase(SQLModel):
    date_updated: Optional[datetime]
    updated_by: Optional[int] = Field(default=None, foreign_key="system_user.id")


class ApprovedBase(SQLModel):
    date_approved: Optional[datetime]
    approved_by: Optional[int] = Field(default=None, foreign_key="system_user.id")


class CanceledBase(SQLModel):
    date_canceled: Optional[datetime]
    canceled_by: Optional[int] = Field(default=None, foreign_key="system_user.id")
    canceled_remarks: Optional[str]


class DeletedBase(SQLModel):
    date_deleted: Optional[datetime]
    deleted_by: Optional[int] = Field(default=None, foreign_key="system_user.id")
    is_deleted: bool = Field(default=False)
