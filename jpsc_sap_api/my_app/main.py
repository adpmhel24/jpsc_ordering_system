from fastapi import APIRouter, FastAPI

from fastapi_sqlalchemy import DBSessionMiddleware, db
from starlette.middleware.cors import CORSMiddleware


from my_app.handlers.error_handler import RouteErrorHandler
from .configs import settings

app = FastAPI(
    title=settings.PROJECT_NAME, openapi_url=f"{settings.API_V1_STR}/openapi.json"
)
app.add_middleware(DBSessionMiddleware, db_url=settings.SQLALCHEMY_DATABASE_URI)

# Set all CORS enabled origins
if settings.BACKEND_CORS_ORIGINS:
    app.add_middleware(
        CORSMiddleware,
        allow_origins=settings.BACKEND_CORS_ORIGINS,
        allow_credentials=True,
        allow_methods=["*"],
        allow_headers=["*"],
    )

router = APIRouter(route_class=RouteErrorHandler)
app.include_router(router)


def dictfetchall(cursorResult):
    columns = [column[0] for column in cursorResult.cursor.description]

    return [dict(zip(columns, row)) for row in cursorResult.fetchall()]


@app.get("/products/lastPurchPrc")
async def products_last_purchase_price():
    statement = "SELECT* FROM v_itemLastPurch ORDER BY ItemCode"
    curr = db.session.execute(statement)
    result = dictfetchall(curr)
    return {"data": result}
