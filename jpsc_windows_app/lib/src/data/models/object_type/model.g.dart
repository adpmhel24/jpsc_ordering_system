// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ObjectTypeModel _$ObjectTypeModelFromJson(Map<String, dynamic> json) =>
    ObjectTypeModel(
      id: json['id'] as int,
      name: json['name'] as String,
      menuGroupCode: json['menu_group_code'] as String,
    );

Map<String, dynamic> _$ObjectTypeModelToJson(ObjectTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'menu_group_code': instance.menuGroupCode,
    };
