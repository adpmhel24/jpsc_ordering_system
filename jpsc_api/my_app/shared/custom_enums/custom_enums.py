import enum


class DocstatusEnum(str, enum.Enum):
    open = "O"
    closed = "C"
    canceled = "N"


class PQStatusEnum(int, enum.Enum):
    for_price_confirmation = 0
    price_confirmed = 1
    with_sap_sq = 2


class DeliveryMethodEnum(str, enum.Enum):
    pickup = "Pickup"
    delivery = "Delivery"
