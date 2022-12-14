// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PriceQuotationModel _$PriceQuotationModelFromJson(Map<String, dynamic> json) =>
    PriceQuotationModel(
      id: json['id'] as int?,
      transdate: DateTime.parse(json['transdate'] as String),
      customerCode: json['customer_code'] as String,
      deliveryDate: DateTime.parse(json['delivery_date'] as String),
      deliveryMethod: json['delivery_method'] as String?,
      paymentTerms: json['payment_terms'] as String?,
      remarks: json['remarks'] as String?,
      dispatchingBranch: json['dispatching_branch'] as String?,
      hashedId: json['hashed_id'] as String,
      contactNumber: json['contact_number'] as String?,
      address: json['address'] as String?,
      customerNotes: json['customer_notes'] as String?,
      reference: json['reference'] as String,
      docstatus: json['docstatus'] as String,
      pqStatus: json['pq_status'] as int,
      dateDispatched: json['date_dispatched'] == null
          ? null
          : DateTime.parse(json['date_dispatched'] as String),
      paymentReference: json['payment_reference'] as String?,
      subtotal: (json['subtotal'] as num?)?.toDouble(),
      gross: (json['gross'] as num?)?.toDouble(),
      delfee: (json['delfee'] as num?)?.toDouble(),
      otherfee: (json['otherfee'] as num?)?.toDouble(),
      dateConfirmed: json['date_confirmed'] == null
          ? null
          : DateTime.parse(json['date_confirmed'] as String),
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      dateCreated: json['date_created'] == null
          ? null
          : DateTime.parse(json['date_created'] as String),
      dateCanceled: json['date_canceled'] == null
          ? null
          : DateTime.parse(json['date_canceled'] as String),
      canceledRemarks: json['canceled_remarks'] as String?,
      createdByUser: json['created_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['created_by_user'] as Map<String, dynamic>),
      canceledByUser: json['canceled_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['canceled_by_user'] as Map<String, dynamic>),
      approvedByUser: json['approved_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['approved_by_user'] as Map<String, dynamic>),
      confirmedByUser: json['confirmed_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['confirmed_by_user'] as Map<String, dynamic>),
      dipatchedByUser: json['dispatched_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['dispatched_by_user'] as Map<String, dynamic>),
      dateApproved: json['date_approved'] == null
          ? null
          : DateTime.parse(json['date_approved'] as String),
      approvedBy: json['approved_by'] as int?,
      sqNumber: json['sq_number'] as int?,
      rows: (json['rows'] as List<dynamic>)
          .map(
              (e) => PriceQuotationRowModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..createdBy = json['created_by'] as int?
      ..updatedBy = json['updated_by'] as int?
      ..confirmedBy = json['confirmed_by'] as int?
      ..dispatchedBy = json['dispatched_by'] as int?
      ..updatedByUser = json['updated_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['updated_by_user'] as Map<String, dynamic>);

Map<String, dynamic> _$PriceQuotationModelToJson(PriceQuotationModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'transdate': instance.transdate.toIso8601String(),
    'customer_code': instance.customerCode,
    'delivery_date': instance.deliveryDate.toIso8601String(),
    'delivery_method': instance.deliveryMethod,
    'payment_terms': instance.paymentTerms,
    'remarks': instance.remarks,
    'dispatching_branch': instance.dispatchingBranch,
    'hashed_id': instance.hashedId,
    'contact_number': instance.contactNumber,
    'address': instance.address,
    'customer_notes': instance.customerNotes,
    'reference': instance.reference,
    'docstatus': instance.docstatus,
    'pq_status': instance.pqStatus,
    'date_dispatched': instance.dateDispatched?.toIso8601String(),
    'payment_reference': instance.paymentReference,
    'subtotal': instance.subtotal,
    'gross': instance.gross,
    'delfee': instance.delfee,
    'otherfee': instance.otherfee,
    'sq_number': instance.sqNumber,
    'date_confirmed': instance.dateConfirmed?.toIso8601String(),
    'date_updated': instance.dateUpdated?.toIso8601String(),
    'date_created': instance.dateCreated?.toIso8601String(),
    'date_canceled': instance.dateCanceled?.toIso8601String(),
    'date_approved': instance.dateApproved?.toIso8601String(),
    'canceled_remarks': instance.canceledRemarks,
    'created_by': instance.createdBy,
    'updated_by': instance.updatedBy,
    'confirmed_by': instance.confirmedBy,
    'approved_by': instance.approvedBy,
    'dispatched_by': instance.dispatchedBy,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull(
      'created_by_user', PriceQuotationModel.toNull(instance.createdByUser));
  writeNotNull(
      'updated_by_user', PriceQuotationModel.toNull(instance.updatedByUser));
  writeNotNull(
      'approved_by_user', PriceQuotationModel.toNull(instance.approvedByUser));
  writeNotNull(
      'canceled_by_user', PriceQuotationModel.toNull(instance.canceledByUser));
  writeNotNull('confirmed_by_user',
      PriceQuotationModel.toNull(instance.confirmedByUser));
  writeNotNull('dispatched_by_user',
      PriceQuotationModel.toNull(instance.dipatchedByUser));
  val['rows'] = PriceQuotationModel._rowsToJson(instance.rows);
  return val;
}
