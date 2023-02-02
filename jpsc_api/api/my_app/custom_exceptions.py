# from .main import app
# from fastapi.exceptions import RequestValidationError
# from fastapi.responses import JSONResponse
# from sqlalchemy.exc import SQLAlchemyError
# from fastapi import Request, status
# from fastapi.encoders import jsonable_encoder
# from starlette.exceptions import HTTPException as StarletteHTTPException

# from my_app.shared.utils import logger


# @app.exception_handler(RequestValidationError)
# async def validation_exception_handler(request: Request, exc: RequestValidationError):
#     return JSONResponse(
#         status_code=status.HTTP_422_UNPROCESSABLE_ENTITY,
#         content=jsonable_encoder({"message": exc.errors()[0]["msg"]}),
#     )


# @app.exception_handler(AttributeError)
# async def attribute_error_handler(request, err):
#     # base_error_message = f"Failed to execute: {request.method}: {request.url}"
#     # Change here to LOGGER
#     logger.exception(err.args)
#     return JSONResponse(
#         status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
#     )


# @app.exception_handler(StarletteHTTPException)
# async def http_exception_handler(request, exc):
#     return JSONResponse(
#         status_code=exc.status_code, content=jsonable_encoder({"message": exc.detail})
#     )


# @app.exception_handler(TypeError)
# async def type_error_handler(request, err):
#     # base_error_message = f"Failed to execute: {request.method}: {request.url}"
#     # Change here to LOGGER
#     logger.exception(request)
#     return JSONResponse(
#         status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err}"}
#     )


# @app.exception_handler(SQLAlchemyError)
# async def sqlalchemy_error_handler(request, err):
#     logger.exception(err.args)
#     return JSONResponse(
#         status_code=status.HTTP_400_BAD_REQUEST, content={"message": f"{err.args}"}
#     )
