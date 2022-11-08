// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateItemGroupModel _$CreateItemGroupModelFromJson(
        Map<String, dynamic> json) =>
    CreateItemGroupModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$CreateItemGroupModelToJson(
        CreateItemGroupModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
    };
