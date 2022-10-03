// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UomGroupModel _$UomGroupModelFromJson(Map<String, dynamic> json) =>
    UomGroupModel(
      code: json['code'] as String,
      description: json['description'] as String,
      baseQty: (json['base_qty'] as num).toDouble(),
      baseUom: json['base_uom'] as String,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$UomGroupModelToJson(UomGroupModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'base_qty': instance.baseQty,
      'base_uom': instance.baseUom,
      'is_active': instance.isActive,
    };
