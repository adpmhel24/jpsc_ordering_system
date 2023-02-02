from my_app.shared.schemas.base_schemas import PrimaryKeyBase
from my_app.core.modules.Inventory.inv_transaction.schema import InvTransactionBase


class InvTransaction(InvTransactionBase, PrimaryKeyBase, table=True):
    __tablename__ = "inv_transaction"
    pass
