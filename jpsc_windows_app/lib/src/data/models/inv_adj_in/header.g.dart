// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryAdjustmentInHeader _$InventoryAdjustmentInHeaderFromJson(
        Map<String, dynamic> json) =>
    InventoryAdjustmentInHeader(
      id: json['id'] as int,
      reference: json['reference'] as String,
      docstatus: json['docstatus'] as String,
      transdate: DateTime.parse(json['transdate'] as String),
      dateCreated: DateTime.parse(json['date_created'] as String),
      createdBy: SystemUserModel.fromJson(
          json['created_by_user'] as Map<String, dynamic>),
      updatedBy: json['updated_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['updated_by_user'] as Map<String, dynamic>),
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      remarks: json['remarks'] as String?,
    );

Map<String, dynamic> _$InventoryAdjustmentInHeaderToJson(
        InventoryAdjustmentInHeader instance) =>
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
    };
