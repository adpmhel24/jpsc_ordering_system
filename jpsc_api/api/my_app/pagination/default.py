from __future__ import annotations
from abc import ABC

from typing import Generic, Sequence, TypeVar

from fastapi import Query
from pydantic import BaseModel, conint

from fastapi_pagination.bases import AbstractParams, AbstractPage, RawParams


T = TypeVar("T")


class Params(BaseModel, AbstractParams):
    page: int = Query(1, ge=1, description="Page number")
    size: int = Query(10, ge=1, le=100, description="Page size")

    def to_raw_params(self) -> RawParams:
        return RawParams(
            limit=self.size,
            offset=self.size * (self.page - 1),
        )


class BasePage(AbstractPage[T], Generic[T], ABC):
    data: Sequence[T]
    total: conint(ge=0)  # type: ignore


class Page(BasePage[T], Generic[T]):
    page: conint(ge=1)  # type: ignore
    size: conint(ge=1)  # type: ignore

    __params_type__ = Params

    @classmethod
    def create(
        cls,
        data: Sequence[T],
        total: int,
        params: AbstractParams,
    ) -> Page[T]:
        if not isinstance(params, Params):
            raise ValueError("Page should be used with Params")

        return cls(
            total=total,
            data=data,
            page=params.page,
            size=params.size,
        )


__all__ = [
    "Params",
    "Page",
]
