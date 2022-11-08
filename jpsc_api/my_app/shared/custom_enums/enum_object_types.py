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
    price_quotation = 9
    sales_delivery = 10
    sales_invoice = 11
    sales_order = 12
    system_user = 1001
    item_data = 1002
    uom_data = 1003
    branch_data = 1004
    customer_data = 1005
    customer_type_data = 1006
    item_group_data = 1007
    pricelist_data = 1008
    payment_terms_data = 1009
