from fastapi import APIRouter
from .inv_adjustment_in.routes import router as inv_adj_in_router
from .inv_adjustment_out.routes import router as inv_adj_out_router
from .inv_transfer_request.routes import router as inv_transfer_request_router
from .inv_transfer.routes import router as inv_transfer_router
from .inv_receive.routes import router as inv_receive_router

inventory_router = APIRouter(prefix="/inventory")


inventory_router.include_router(
    inv_adj_in_router, prefix="/inv_adj_in", tags=["Inventory Adjustment In"]
)
inventory_router.include_router(
    inv_adj_out_router, prefix="/inv_adj_out", tags=["Inventory Adjustment Out"]
)
inventory_router.include_router(
    inv_transfer_request_router,
    prefix="/inv_transfer_request",
    tags=["Inventory Transfer Request"],
)
inventory_router.include_router(
    inv_transfer_router, prefix="/inv_transfer", tags=["Inventory Transfer"]
)
inventory_router.include_router(
    inv_receive_router, prefix="/inv_receive", tags=["Inventory Receive"]
)
