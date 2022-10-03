from typing import Any, Generic, Optional, Sequence, Type, TypeVar
from pydantic import BaseModel


from pydantic.generics import GenericModel

T = TypeVar("T")


class SuccessMessage(GenericModel, Generic[T]):
    message: Optional[str] = "Success"
    count: Optional[int]
    data: T
