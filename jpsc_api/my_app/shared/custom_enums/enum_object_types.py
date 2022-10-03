import enum


class ObjectTypesEnum(str, enum.Enum):
    inv_adjustment_in = 1
    inv_adjustment_out = 2
    inv_transfer_request = 3
    inv_transfer = 4
    inv_receive = 5
    purchase_order = 6
    purchase_receive = 7
    ap_invoice = 8
    sales_order = 9
    sales_delivery = 10
    sales_invoice = 11
