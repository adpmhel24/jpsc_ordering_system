// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemGroupModel _$ItemGroupModelFromJson(Map<String, dynamic> json) =>
    ItemGroupModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$ItemGroupModelToJson(ItemGroupModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
    };
