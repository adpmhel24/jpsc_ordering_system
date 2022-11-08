from calendar import c
from my_app.core.settings.config import settings
from my_app.core.settings.security import get_password_hash
from ..core.modules.MasterData.system_user.cruds import crud_sys_user, SystemUser
from my_app.core.modules.MasterData.object_type.models import ObjectType
from my_app.core.modules.MasterData.menu_group.models import MenuGroup
from my_app.shared.custom_enums.enum_object_types import ObjectTypesEnum
from my_app.main import db


def create_initial_su(db) -> None:
    # Create initial super user

    user_query = crud_sys_user.get_super_admin()
    if not user_query:
        user = crud_sys_user.get_by_email(email=settings.FIRST_SUPERUSER_EMAIL)

        if not user:
            user_obj = SystemUser(
                email=settings.FIRST_SUPERUSER_EMAIL,
                is_super_admin=True,
                first_name="Admin",
            )
            user_obj.hashed_password = get_password_hash(
                settings.FIRST_SUPERUSER_PASSWORD
            )
            db.session.add(user_obj)
            db.session.commit()
            db.session.refresh(user_obj)


def new_menu_group(db):
    menu_groups = [
        MenuGroup(code="Master Data"),
        MenuGroup(code="Inventory"),
        MenuGroup(code="Sales"),
        MenuGroup(code="Purchasing"),
    ]
    for menu_group_obj in menu_groups:
        existing_menu_group = (
            db.session.query(MenuGroup).filter_by(code=menu_group_obj.code).first()
        )
        if not existing_menu_group:
            db.session.add(menu_group_obj)
            db.session.commit()
            db.session.refresh(menu_group_obj)


def new_object_type(db):

    object_types = [
        ObjectType(
            id=ObjectTypesEnum.inv_adjustment_in,
            name="Inventory Adjustment In",
            menu_group_code="Inventory",
        ),
        ObjectType(
            id=ObjectTypesEnum.inv_adjustment_out,
            name="Inventory Adjustment Out",
            menu_group_code="Inventory",
        ),
        ObjectType(
            id=ObjectTypesEnum.inv_transfer_request,
            name="Inventory Transfer Request",
            menu_group_code="Inventory",
        ),  # Inventory transfer request
        ObjectType(
            id=ObjectTypesEnum.inv_transfer,
            name="Inventory Transfer",
            menu_group_code="Inventory",
        ),  # Inventory transfer
        ObjectType(
            id=ObjectTypesEnum.inv_receive,
            name="Inventory Transfer Received",
            menu_group_code="Inventory",
        ),  # Inventory transfer Receive
        ObjectType(
            id=ObjectTypesEnum.purchase_order,
            name="Purchase Order",
            menu_group_code="Purchasing",
        ),  # Purchase Order
        ObjectType(
            id=ObjectTypesEnum.purchase_receive,
            name="Purchase Order Receive",
            menu_group_code="Purchasing",
        ),  # Item Receive PO
        ObjectType(
            id=ObjectTypesEnum.ap_invoice,
            name="AP Invoice",
            menu_group_code="Purchasing",
        ),  # Account Payable
        ObjectType(
            id=ObjectTypesEnum.price_quotation,
            name="Price Quotation",
            menu_group_code="Sales",
        ),  # Sales Order
        ObjectType(
            id=ObjectTypesEnum.sales_delivery,
            name="Delivery",
            menu_group_code="Sales",
        ),  # Sales Delivery
        ObjectType(
            id=ObjectTypesEnum.sales_invoice,
            name="Sales Invoice",
            menu_group_code="Sales",
        ),
        ObjectType(
            id=ObjectTypesEnum.system_user,
            name="System User",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.item_data,
            name="Item",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.uom_data,
            name="Unit Of Measure",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.branch_data,
            name="Branch",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.customer_data,
            name="Customer Data",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.customer_type_data,
            name="Customer Type",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.item_group_data,
            name="Item Group",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.pricelist_data,
            name="Pricelist",
            menu_group_code="Master Data",
        ),
        ObjectType(
            id=ObjectTypesEnum.payment_terms_data,
            name="Payment Terms",
            menu_group_code="Master Data",
        ),
    ]
    for objtype in object_types:
        object_obj = db.session.query(ObjectType).get(objtype.id)
        if not object_obj:
            db.session.add(objtype)
            db.session.commit()
            db.session.refresh(objtype)


def db_init_setup() -> None:
    with db():
        new_menu_group(db)
        new_object_type(db)
        create_initial_su(db)
