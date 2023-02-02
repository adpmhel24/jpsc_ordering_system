from .models import PaymentTermsBase, PaymentTerms


class PaymentTermsCreate(PaymentTermsBase):
    """Create Schema"""

    pass


class PaymentTermsUpdate(PaymentTerms):
    pass


class PaymentTermsRead(PaymentTerms):
    """Read Schema"""

    pass
