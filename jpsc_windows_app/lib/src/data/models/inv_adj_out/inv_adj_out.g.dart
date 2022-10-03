// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inv_adj_out.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryAdjustmentOutModel _$InventoryAdjustmentOutModelFromJson(
        Map<String, dynamic> json) =>
    InventoryAdjustmentOutModel(
      id: json['id'] as int,
      reference: json['reference'] as String,
      docstatus: json['docstatus'] as String,
      transdate: DateTime.parse(json['transdate'] as String),
      dateCreated: DateTime.parse(json['date_created'] as String),
      createdBy: SystemUserModel.fromJson(
          json['created_by_user'] as Map<String, dynamic>),
      rows: (json['rows'] as List<dynamic>)
          .map((e) =>
              InventoryAdjustmentOutRow.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..dateUpdated = json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String)
      ..updatedBy = json['updated_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['updated_by_user'] as Map<String, dynamic>)
      ..remarks = json['remarks'] as String?;

Map<String, dynamic> _$InventoryAdjustmentOutModelToJson(
        InventoryAdjustmentOutModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'reference': instance.reference,
      'docstatus': instance.docstatus,
      'transdate': instance.transdate.toIso8601String(),
      'date_created': instance.dateCreated.toIso8601String(),
      'created_by_user': instance.createdBy,
      'date_updated': instance.dateUpdated?.toIso8601String(),
      'updated_by_user': instance.updatedBy,
      'remarks': instance.remarks,
      'rows': instance.rows,
    };
