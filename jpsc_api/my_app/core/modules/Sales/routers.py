from fastapi import APIRouter
from .sales_order import router as sales_order_router

sales_router = APIRouter(prefix="/sales")


sales_router.include_router(sales_order_router, prefix="/order", tags=["Sales Order"])
