from fastapi import FastAPI
from fastapi.encoders import jsonable_encoder
from fastapi_pagination import add_pagination
from my_app.error_handler import RouteErrorHandler
from my_app.core.settings.config import settings
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from sqlalchemy.exc import SQLAlchemyError
from fastapi import Request, status
from starlette.exceptions import HTTPException as StarletteHTTPException
from starlette.middleware.cors import CORSMiddleware
from fastapi import Request, APIRouter, FastAPI
from fastapi_sqlalchemy import DBSessionMiddleware  # middleware helper
from fastapi_sqlalchemy import db
from my_app.core.settings.config import settings

from my_app.shared.utils import logger
from my_app.core.modules.routers import *

router = APIRouter(route_class=RouteErrorHandler)

app = FastAPI(
    title=settings.PROJECT_NAME, openapi_url=f"{settings.API_V1_STR}/openapi.json"
)

app.add_middleware(DBSessionMiddleware, db_url=settings.SQLALCHEMY_DATABASE_URI)


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    return JSONResponse(
        status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
        content=jsonable_encoder({"message": exc.errors()[0]["msg"]}),
    )


@app.exception_handler(AttributeError)
async def attribute_error_handler(request, err):
    # base_error_message = f"Failed to execute: {request.method}: {request.url}"
    # Change here to LOGGER

    logger.exception(err.args)
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
    )


@app.exception_handler(StarletteHTTPException)
async def http_exception_handler(request, exc):
    return JSONResponse(
        status_code=exc.status_code, content=jsonable_encoder({"message": exc.detail})
    )


@app.exception_handler(TypeError)
async def type_error_handler(request, err):
    # base_error_message = f"Failed to execute: {request.method}: {request.url}"
    # Change here to LOGGER
    logger.exception(request)
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err}"}
    )


@app.exception_handler(SQLAlchemyError)
async def sqlalchemy_error_handler(request, err):
    logger.exception(err.args)
    return JSONResponse(
        status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
    )


# Set all CORS enabled origins
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.BACKEND_CORS_ORIGINS,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

app.include_router(router)
app.include_router(login_router, prefix=settings.API_V1_STR)
app.include_router(master_data_router, prefix=settings.API_V1_STR)
app.include_router(inventory_router, prefix=settings.API_V1_STR)
app.include_router(sales_router, prefix=settings.API_V1_STR)
add_pagination(app)


@app.get("/")
def index():
    return {"title": "Welcome"}
