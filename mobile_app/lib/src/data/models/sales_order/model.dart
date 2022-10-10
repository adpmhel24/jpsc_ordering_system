import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class PriceQuotationModel {
  int? id;
  String? transdate;
  String? customerCode;
  String? deliveryDate;
  String? deliveryMethod;
  String? paymentMethod;
  String? remarks;
  String? dispatchingBranch;
  String? hashedId;
  String? contactNumber;
  String? address;
  String? customerNotes;
  String? reference;
  String? docstatus;
  int? sqNumber;
  int? pqStatus;
  String? dateDispatched;
  String? paymentReference;
  double? subtotal;
  double? gross;
  double? delfee;
  double? otherfee;
  int? confirmedBy;
  String? dateConfirmed;
  int? dispatchedBy;
  String? dateUpdated;
  int? updatedBy;
  String? dateCreated;
  int? createdBy;
  String? dateCanceled;
  int? canceledBy;
  String? canceledRemarks;
  List<SalesOrderRowModel>? rows;

  PriceQuotationModel({
    this.id,
    this.transdate,
    this.customerCode,
    this.deliveryDate,
    this.deliveryMethod,
    this.paymentMethod,
    this.remarks,
    this.dispatchingBranch,
    this.hashedId,
    this.contactNumber,
    this.address,
    this.customerNotes,
    this.reference,
    this.docstatus,
    this.sqNumber,
    this.pqStatus,
    this.dateDispatched,
    this.paymentReference,
    this.subtotal,
    this.gross,
    this.delfee,
    this.otherfee,
    this.confirmedBy,
    this.dateConfirmed,
    this.dispatchedBy,
    this.dateUpdated,
    this.updatedBy,
    this.dateCreated,
    this.createdBy,
    this.dateCanceled,
    this.canceledBy,
    this.canceledRemarks,
    this.rows,
  });

  PriceQuotationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    transdate = json['transdate'];
    customerCode = json['customer_code'];
    deliveryDate = json['delivery_date'];
    deliveryMethod = json['delivery_method'];
    paymentMethod = json['payment_method'];
    remarks = json['remarks'];
    dispatchingBranch = json['dispatching_branch'];
    hashedId = json['hashed_id'];
    contactNumber = json['contact_number'];
    address = json['address'];
    customerNotes = json['customer_notes'];
    reference = json['reference'];
    docstatus = json['docstatus'];
    sqNumber = json['sq_number'];
    pqStatus = json['pq_status'];
    dateDispatched = json['date_dispatched'];
    paymentReference = json['payment_reference'];
    subtotal = json['subtotal'];
    gross = json['gross'];
    delfee = json['delfee'];
    otherfee = json['otherfee'];
    confirmedBy = json['confirmed_by'];
    dateConfirmed = json['date_confirmed'];
    dispatchedBy = json['dispatched_by'];
    dateUpdated = json['date_updated'];
    updatedBy = json['updated_by'];
    dateCreated = json['date_created'];
    createdBy = json['created_by'];
    dateCanceled = json['date_canceled'];
    canceledBy = json['canceled_by'];
    canceledRemarks = json['canceled_remarks'];
    if (json['rows'] != null) {
      rows = <SalesOrderRowModel>[];
      json['rows'].forEach((v) {
        rows!.add(SalesOrderRowModel.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['transdate'] = transdate;
    data['customer_code'] = customerCode;
    data['delivery_date'] = deliveryDate;
    data['delivery_method'] = deliveryMethod;
    data['payment_method'] = paymentMethod;
    data['remarks'] = remarks;
    data['dispatching_branch'] = dispatchingBranch;
    data['hashed_id'] = hashedId;
    data['contact_number'] = contactNumber;
    data['address'] = address;
    data['customer_notes'] = customerNotes;
    data['reference'] = reference;
    data['docstatus'] = docstatus;
    data['sq_number'] = sqNumber;
    data['pq_status'] = pqStatus;
    data['date_dispatched'] = dateDispatched;
    data['payment_reference'] = paymentReference;
    data['subtotal'] = subtotal;
    data['gross'] = gross;
    data['delfee'] = delfee;
    data['otherfee'] = otherfee;
    data['confirmed_by'] = confirmedBy;
    data['date_confirmed'] = dateConfirmed;
    data['dispatched_by'] = dispatchedBy;
    data['date_updated'] = dateUpdated;
    data['updated_by'] = updatedBy;
    data['date_created'] = dateCreated;
    data['created_by'] = createdBy;
    data['date_canceled'] = dateCanceled;
    data['canceled_by'] = canceledBy;
    data['canceled_remarks'] = canceledRemarks;
    if (rows != null) {
      data['rows'] = rows!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SalesOrderRowModel {
  int? id;
  String? itemCode;
  double? quantity;
  double? srpPrice;
  double? unitPrice;
  String? uom;
  int? docId;
  double? linetotal;

  SalesOrderRowModel(
      {this.id,
      this.itemCode,
      this.quantity,
      this.srpPrice,
      this.unitPrice,
      this.uom,
      this.docId,
      this.linetotal});

  SalesOrderRowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    itemCode = json['item_code'];
    quantity = json['quantity'];
    srpPrice = json['srp_price'];
    unitPrice = json['unit_price'];
    uom = json['uom'];
    docId = json['doc_id'];
    linetotal = json['linetotal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['item_code'] = itemCode;
    data['quantity'] = quantity;
    data['srp_price'] = srpPrice;
    data['unit_price'] = unitPrice;
    data['uom'] = uom;
    data['doc_id'] = docId;
    data['linetotal'] = linetotal;
    return data;
  }
}
