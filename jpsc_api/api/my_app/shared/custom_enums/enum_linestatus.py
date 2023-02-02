import enum


class LineStatusEnum(str, enum.Enum):
    open = "Open"
    closed = "Closed"
    canceled = "Canceled"
