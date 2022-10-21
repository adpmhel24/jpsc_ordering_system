// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthorizationModel _$AuthorizationModelFromJson(Map<String, dynamic> json) =>
    AuthorizationModel(
      id: json['id'] as int,
      systemUserId: json['system_user_id'] as int,
      objtype: json['objtype'] as int,
      full: json['full'] as bool,
      read: json['read'] as bool,
      create: json['create'] as bool,
      approve: json['approve'] as bool,
      update: json['update'] as bool,
      objectTypeObj: AuthorizationModel._fromJson(
          json['object_type_obj'] as Map<String, dynamic>?),
    );

Map<String, dynamic> _$AuthorizationModelToJson(AuthorizationModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'system_user_id': instance.systemUserId,
      'objtype': instance.objtype,
      'full': instance.full,
      'read': instance.read,
      'create': instance.create,
      'approve': instance.approve,
      'update': instance.update,
      'object_type_obj': AuthorizationModel._toJson(instance.objectTypeObj),
    };
