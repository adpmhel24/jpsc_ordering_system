# from fastapi import HTTPException, status
# from typing import Any, Dict, List, Optional, Union
# from sqlmodel import Session, or_, func, and_

# from .. import cruds, models


# class CRUDWhseInv(
#     cruds.CRUDBase[
#         models.WhseInv, models.WhseInvCreate, models.WhseInvUpdate, models.WhseInvRead
#     ]
# ):
#     def create(
#         self,
#         db: Session,
#         *,
#         create_schema: models.WhseInvCreate,
#         user_id: int,
#     ) -> Any:

#         # Check if WhseInv name was passed is already exist
#         WhseInv_obj = (
#             db.query(self.model)
#             .filter(func.lower(self.model.name) == create_schema.name.lower())
#             .first()
#         )
#         if WhseInv_obj:
#             raise HTTPException(
#                 status_code=status.HTTP_400_BAD_REQUEST,
#                 detail="WhseInv name already exist.",
#             )
#         # create schema model to dict
#         c_dict = create_schema.dict()

#         db_obj = models.WhseInv(**c_dict)
#         db_obj.created_by = user_id

#         db.add(db_obj)
#         db.commit()
#         db.refresh(db_obj)
#         return db_obj

#     def get_all(
#         self,
#         db: Session,
#         *,
#         is_active: Optional[bool],
#     ) -> Any:
#         db_obj = (
#             db.query(self.model)
#             .filter(
#                 or_(
#                     not is_active,
#                     self.model.is_active.is_(is_active),
#                 )
#             )
#             .order_by(self.model.name)
#             .all()
#         )
#         return db_obj

#     def update(
#         self,
#         db: Session,
#         fk: str,
#         *,
#         update_schema: Union[models.WhseInvUpdate, Dict[str, Any]],
#     ) -> Any:
#         db_obj = self.get(db=db, fk=fk)
#         if not db_obj:
#             raise HTTPException(
#                 status_code=status.HTTP_404_NOT_FOUND, detail="Invalid WhseInv name."
#             )
#         existing_obj = (
#             db.query(self.model)
#             .filter(
#                 and_(
#                     func.lower(self.model.name) == update_schema.name.lower(),
#                     self.model.name != fk,
#                 )
#             )
#             .first()
#         )
#         if existing_obj:
#             raise HTTPException(
#                 status_code=status.HTTP_400_BAD_REQUEST,
#                 detail="WhseInv Name Already exist.",
#             )
#         if isinstance(update_schema, dict):
#             update_data = update_schema
#         else:
#             update_data = update_schema.dict(exclude_unset=True)

#         return super().update( db_obj=db_obj, obj_in=update_data)


# crud_WhseInv = CRUDWhseInv(models.WhseInv)
