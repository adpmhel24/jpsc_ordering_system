// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricelistModel _$PricelistModelFromJson(Map<String, dynamic> json) =>
    PricelistModel(
      code: json['code'] as String?,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool?,
      rows: (json['rows'] as List<dynamic>?)
          ?.map((e) => PricelistRowModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PricelistModelToJson(PricelistModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
      'rows': instance.rows,
    };
