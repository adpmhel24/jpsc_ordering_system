// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUserModel _$SystemUserModelFromJson(Map<String, dynamic> json) =>
    SystemUserModel(
      id: json['id'] as int,
      email: json['email'] as String,
      firstName: json['first_name'] as String? ?? '',
      lastName: json['last_name'] as String? ?? '',
      positionCode: json['position_code'] as String?,
      assignedBranch: (json['assigned_branch'] as List<dynamic>?)
              ?.map((e) =>
                  SystemUserBranchModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      itemGroupAuth: (json['item_group_auth'] as List<dynamic>?)
              ?.map(
                  (e) => AuthItemGroupModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      isActive: json['is_active'] as bool,
      isSuperAdmin: json['is_super_admin'] as bool,
      authorizations:
          SystemUserModel._authFromJson(json['authorizations'] as List),
    );

Map<String, dynamic> _$SystemUserModelToJson(SystemUserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_active': instance.isActive,
      'is_super_admin': instance.isSuperAdmin,
      'position_code': instance.positionCode,
      'id': instance.id,
      'assigned_branch': instance.assignedBranch,
      'authorizations': SystemUserModel._authToJson(instance.authorizations),
      'item_group_auth': instance.itemGroupAuth,
    };
