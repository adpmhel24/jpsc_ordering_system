from __future__ import annotations

from math import ceil
from fastapi import Query
from typing import Any, Generic, Optional, TypeVar
from pydantic import conint, root_validator, conint
from fastapi_pagination.links.bases import create_links, Links


from .default import Page as BasePage, Params


T = TypeVar("T")


class CustomPage(BasePage[T], Generic[T]):

    links: Links
    first_page: conint(ge=1)  # type: ignore
    last_page: conint(ge=1)  # type: ignore
    prev_page: Optional[int]  # type: ignore
    next_page: Optional[int]  # type: ignore

    @root_validator(pre=True)
    def __root_validator__(cls, value: Any) -> Any:
        if "links" not in value:
            page, size, total = [value[k] for k in ("page", "size", "total")]

            value["first_page"] = 1
            value["last_page"] = ceil(total / size) if total > 0 else 1
            value["next_page"] = page + 1 if page * size < total else None
            value["prev_page"] = page - 1 if 1 <= page - 1 else None

            value["links"] = create_links(
                first={"page": 1},
                last={"page": ceil(total / size) if total > 0 else 1},
                next={"page": page + 1} if page * size < total else None,
                prev={"page": page - 1} if 1 <= page - 1 else None,
            )

        return value


__all__ = ["Params", "CustomPage"]
