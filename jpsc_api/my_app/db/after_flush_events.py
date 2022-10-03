# from sqlalchemy import event
# from my_app.shared.custom_enums.enum_docstatus import DocstatusEnum
# from my_app.shared.custom_enums.enum_linestatus import LineStatusEnum
# from my_app.core.modules.MasterData.models import *
# from my_app.core.modules.Inventory.models import *
# from sqlalchemy.orm import Session
# from fastapi_sqlalchemy import db


# @event.listens_for(Session, "after_flush")
# def track_instances_after_flush(*args):
#     sess = args[0]
#     for obj in sess.new:
#         if isinstance(obj, InvTrfrRow):  # InvTrfrRow Instance
#             if obj.base_id and obj.base_objtype == 3:
#                 # Get the the Transfer Request
#                 trfr_req_row = db.session.query(InvTrfrReqRow).get(obj.base_row_id)
#                 trfr_req_row.balance -= obj.quantity  # Update the balance
#                 if trfr_req_row.balance <= 0:
#                     # Check if the balance is 0 then close the status
#                     trfr_req_row.linestatus = LineStatusEnum.closed

#                 if trfr_req_row.linestatus == LineStatusEnum.closed:
#                     # Query all the transfer request row with same doc_id
#                     # and check if all rows are closed, then update the docstatus
#                     # of Inv Transfer Reques Header
#                     open_rows = (
#                         db.session.query(InvTrfrReqRow)
#                         .filter(
#                             InvTrfrReqRow.linestatus == LineStatusEnum.open,
#                             InvTrfrReqRow.doc_id == trfr_req_row.doc_id,
#                         )
#                         .count()
#                     )
#                     if not open_rows:  # Check if there is no open status in rows.
#                         trfr_req_header = db.session.query(InvTrfrReqHeader).get()
#                         trfr_req_header.docstatus = DocstatusEnum.closed
#                         db.session.add(trfr_req_header)

#                 db.session.add(trfr_req_row)

#             else:
#                 continue
