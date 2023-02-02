from fastapi import APIRouter
from .price_quotation import router as price_quotation_router

sales_router = APIRouter(prefix="/sales")


sales_router.include_router(
    price_quotation_router, prefix="/pq", tags=["Price Quotation"]
)
