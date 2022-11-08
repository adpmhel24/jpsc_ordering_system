from typing import Callable
from fastapi import APIRouter, HTTPException, Request, Response
from .logging import logger


class RouteErrorHandler(APIRouter):
    """Custom APIRoute that handles application errors and exceptions"""

    def get_route_handler(self) -> Callable:
        original_route_handler = super().get_route_handler()

        async def custom_route_handler(request: Request) -> Response:
            try:
                return await original_route_handler(request)
            except Exception as ex:
                if isinstance(ex, HTTPException):
                    raise ex
                logger.exception("Uncaught error")
                # wrap error into pretty 500 exception
                raise HTTPException(status_code=500, detail=str(ex))

        return custom_route_handler
