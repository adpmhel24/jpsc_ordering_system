// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaymentTermsModel _$PaymentTermsModelFromJson(Map<String, dynamic> json) =>
    PaymentTermsModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      createdBy: json['created_by'] as int?,
      dateCreated: json['date_created'] == null
          ? null
          : DateTime.parse(json['date_created'] as String),
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      updatedBy: json['updated_by'] as int?,
    );

Map<String, dynamic> _$PaymentTermsModelToJson(PaymentTermsModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'date_updated': instance.dateUpdated?.toIso8601String(),
      'updated_by': instance.updatedBy,
      'date_created': instance.dateCreated?.toIso8601String(),
      'created_by': instance.createdBy,
    };
