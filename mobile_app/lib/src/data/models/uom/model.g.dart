// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UomModel _$UomModelFromJson(Map<String, dynamic> json) => UomModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$UomModelToJson(UomModel instance) => <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
    };
