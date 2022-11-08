// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthItemGroupModel _$AuthItemGroupModelFromJson(Map<String, dynamic> json) =>
    AuthItemGroupModel(
      id: json['id'] as int,
      systemUserId: json['system_user_id'] as int,
      itemGroupCode: json['item_group_code'] as String,
      grantLastPurc: json['grant_last_purc'] as bool,
      grantAvgValue: json['grant_avg_value'] as bool,
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      updatedBy: json['updated_by'] as int?,
    );

Map<String, dynamic> _$AuthItemGroupModelToJson(AuthItemGroupModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'system_user_id': instance.systemUserId,
      'item_group_code': instance.itemGroupCode,
      'grant_last_purc': instance.grantLastPurc,
      'grant_avg_value': instance.grantAvgValue,
      'date_updated': instance.dateUpdated?.toIso8601String(),
      'updated_by': instance.updatedBy,
    };
