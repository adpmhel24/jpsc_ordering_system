from my_app.core.settings.config import settings
from my_app.core.settings.security import get_password_hash
from ..core.modules.MasterData.system_user.cruds import crud_sys_user, SystemUser
from my_app.core.modules.MasterData.object_type.models import ObjectType
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


def new_object_type(db):

    object_types = [
        ObjectType(
            id=ObjectTypesEnum.inv_adjustment_in, name="Inventory Adjustment In"
        ),
        ObjectType(
            id=ObjectTypesEnum.inv_adjustment_out, name="Inventory Adjustment Out"
        ),
        ObjectType(
            id=ObjectTypesEnum.inv_transfer_request,
            name="Inventory Transfer Request",
        ),  # Inventory transfer request
        ObjectType(
            id=ObjectTypesEnum.inv_transfer, name="Inventory Transfer"
        ),  # Inventory transfer
        ObjectType(
            id=ObjectTypesEnum.inv_receive, name="Inventory Transfer Received"
        ),  # Inventory transfer Receive
        ObjectType(
            id=ObjectTypesEnum.purchase_order, name="Purchase Order"
        ),  # Purchase Order
        ObjectType(
            id=ObjectTypesEnum.purchase_receive, name="Purchase Order Receive"
        ),  # Item Receive PO
        ObjectType(id=ObjectTypesEnum.ap_invoice, name="AP Invoice"),  # Account Payable
        ObjectType(id=ObjectTypesEnum.sales_order, name="Sales Order"),  # Sales Order
        ObjectType(
            id=ObjectTypesEnum.sales_delivery, name="Delivery"
        ),  # Sales Delivery
        ObjectType(
            id=ObjectTypesEnum.sales_invoice, name="Sales Invoice"
        ),  # Sales Transaction
    ]
    object_obj = db.session.query(ObjectType).first()
    if not object_obj:
        db.session.bulk_save_objects(object_types)
        db.session.commit()


def db_init_setup() -> None:
    with db():
        create_initial_su(db)
        new_object_type(db)
