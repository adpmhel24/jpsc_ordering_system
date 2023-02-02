from fastapi import APIRouter

from .position.routes import router as position_router
from .uom_group.routes import router as uom_group_router
from .item.routes import router as item_router
from .item_group.routes import router as item_group_router
from .uom.routes import router as uom_router
from .warehouse.routes import router as whse_router
from .system_user.routes import router as system_user_router
from .branch.routes import router as branch_router
from .system_user_branch.routes import router as system_user_branch
from .customer.routes import router as customer_router
from .pricelist import router as pricelist_router
from .payment_terms import router as payment_router
from .authorization.routes import router as auth_router
from .menu_group import router as menu_group_router
from .object_type.routes import router as object_type_router
from .menu_group.routes import router as menu_group_router
from .item_group_auth.routes import router as item_group_auth_router
from .app_version.routes import router as app_version_router
from .customer_address.routes import router as customer_address_router

master_data_router = APIRouter(prefix="/master_data")

master_data_router.include_router(
    system_user_router, prefix="/system_users", tags=["System User"]
)
master_data_router.include_router(branch_router, prefix="/branch", tags=["Branch"])
master_data_router.include_router(whse_router, prefix="/warehouse", tags=["Warehouse"])
master_data_router.include_router(uom_router, prefix="/uom", tags=["Unit Of Measure"])
master_data_router.include_router(
    item_group_router, prefix="/item_group", tags=["Item Group"]
)
master_data_router.include_router(item_router, prefix="/item", tags=["Item"])
master_data_router.include_router(
    uom_group_router, prefix="/uom_group", tags=["UoM Group"]
)
master_data_router.include_router(
    position_router, prefix="/position", tags=["Position"]
)
master_data_router.include_router(
    system_user_branch, prefix="/user_branch", tags=["User Branch"]
)
master_data_router.include_router(
    customer_router, prefix="/customer", tags=["Customer"]
)
master_data_router.include_router(
    pricelist_router, prefix="/pricelist", tags=["Pricelist"]
)
master_data_router.include_router(
    payment_router, prefix="/payment_terms", tags=["Payment Term"]
)
master_data_router.include_router(
    auth_router, prefix="/authorization", tags=["Authorization"]
)
master_data_router.include_router(
    menu_group_router, prefix="/menu_group", tags=["Menu Group"]
)
master_data_router.include_router(
    object_type_router, prefix="/object_type", tags=["Object Type"]
)

master_data_router.include_router(
    item_group_auth_router, prefix="/item_group_auth", tags=["Item Group Auth"]
)

master_data_router.include_router(
    app_version_router, prefix="/app_version", tags=["App Version"]
)
master_data_router.include_router(
    customer_address_router, prefix="/customer_address", tags=["Customer Address"]
)
