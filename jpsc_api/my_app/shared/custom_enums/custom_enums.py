import enum


class DocstatusEnum(str, enum.Enum):
    open = "O"
    closed = "C"
    canceled = "N"


class OrderStatusEnum(int, enum.Enum):
    for_price_confirmation = 0
    price_confirmed = 1
    credit_confirmed = 2
    dispatched = 3


class DeliveryMethodEnum(str, enum.Enum):
    pickup = "Pickup"
    delivery = "Delivery"
