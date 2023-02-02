from fastapi import APIRouter
from .routes import router

login_router = APIRouter()
login_router.include_router(router=router, tags=["Login"])
