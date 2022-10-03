// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'header_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricelistHeaderModel _$PricelistHeaderModelFromJson(
        Map<String, dynamic> json) =>
    PricelistHeaderModel(
      code: json['code'] as String,
      description: json['description'] as String,
      isActive: json['is_active'] as bool,
      rows: (json['rows'] as List<dynamic>)
          .map((e) => PricelistRowModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PricelistHeaderModelToJson(
        PricelistHeaderModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
      'rows': instance.rows,
    };
