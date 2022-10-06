import 'package:json_annotation/json_annotation.dart';

import '../models.dart';
import 'row_model.dart';

part 'model.g.dart';

@JsonSerializable()
class SalesOrderModel {
  static toNull(_) => null;

  static List<Map<String, dynamic>>? _rowsToJson(
      List<SalesOrderRowModel> rows) {
    return rows.map((e) => e.toJson()).toList();
  }

  int? id;
  DateTime transdate;

  @JsonKey(name: "customer_code")
  String customerCode;

  @JsonKey(name: "delivery_date")
  DateTime deliveryDate;

  @JsonKey(name: "delivery_method")
  String? deliveryMethod;

  @JsonKey(name: "payment_term")
  String? paymentTerm;

  String? remarks;

  @JsonKey(name: "dispatching_branch")
  String? dispatchingBranch;

  @JsonKey(name: "hashed_id")
  String hashedId;

  @JsonKey(name: "contact_number")
  String? contactNumber;

  String? address;

  @JsonKey(name: "customer_notes")
  String? customerNotes;

  String reference;
  String docstatus;

  @JsonKey(name: "order_status")
  int orderStatus;

  @JsonKey(name: "date_dispatched")
  DateTime? dateDispatched;

  @JsonKey(name: "payment_reference")
  String? paymentReference;

  double? subtotal;
  double? gross;
  double? delfee;
  double? otherfee;

  @JsonKey(name: "date_confirmed")
  DateTime? dateConfirmed;

  @JsonKey(name: "date_udpated")
  DateTime? dateUpdated;

  @JsonKey(name: "date_created")
  DateTime? dateCreated;

  @JsonKey(name: "date_canceled")
  String? dateCanceled;

  String? canceledRemarks;

  @JsonKey(name: "created_by")
  int? createdBy;

  @JsonKey(name: "updated_by")
  int? updatedBy;

  @JsonKey(name: "confirmed_by")
  int? confirmedBy;

  @JsonKey(name: "dispatched_by")
  int? dispatchedBy;

  @JsonKey(name: "created_by_user", toJson: toNull, includeIfNull: false)
  SystemUserModel? createdByUser;

  @JsonKey(name: "updated_by_user", toJson: toNull, includeIfNull: false)
  SystemUserModel? updatedByUser;

  @JsonKey(name: "canceled_by_user", toJson: toNull, includeIfNull: false)
  SystemUserModel? canceledByUser;

  @JsonKey(name: "confirmed_by_user", toJson: toNull, includeIfNull: false)
  SystemUserModel? confirmedByUser;

  @JsonKey(name: "dispatched_by_user", toJson: toNull, includeIfNull: false)
  SystemUserModel? dipatchedByUser;

  @JsonKey(toJson: _rowsToJson)
  List<SalesOrderRowModel> rows;

  SalesOrderModel({
    this.id,
    required this.transdate,
    required this.customerCode,
    required this.deliveryDate,
    this.deliveryMethod,
    this.paymentTerm,
    this.remarks,
    this.dispatchingBranch,
    required this.hashedId,
    this.contactNumber,
    this.address,
    this.customerNotes,
    required this.reference,
    required this.docstatus,
    required this.orderStatus,
    this.dateDispatched,
    this.paymentReference,
    this.subtotal,
    this.gross,
    this.delfee,
    this.otherfee,
    this.dateConfirmed,
    this.dateUpdated,
    this.dateCreated,
    this.dateCanceled,
    this.canceledRemarks,
    required this.createdByUser,
    this.canceledByUser,
    this.confirmedByUser,
    this.dipatchedByUser,
    required this.rows,
  });

  factory SalesOrderModel.fromJson(Map<String, dynamic> json) =>
      _$SalesOrderModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderModelToJson(this);
}
