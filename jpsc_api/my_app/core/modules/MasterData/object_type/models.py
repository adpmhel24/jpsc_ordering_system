from .schemas import ObjectTypeBase


class ObjectType(ObjectTypeBase, table=True):
    __tablename__ = "object_type"
    pass
