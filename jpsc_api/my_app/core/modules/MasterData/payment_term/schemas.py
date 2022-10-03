from .models import PaymentTermBase, PaymentTerm


class PaymentTermCreate(PaymentTermBase):
    """Create Schema"""

    pass


class PaymentTermUpdate(PaymentTerm):
    pass


class PaymentTermRead(PaymentTerm):
    """Read Schema"""

    pass
