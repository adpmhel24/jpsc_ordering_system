// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthUserModel _$AuthUserModelFromJson(Map<String, dynamic> json) =>
    AuthUserModel(
      id: json['id'] as int,
      fullName: json['full_name'] as String? ?? '',
      isActive: json['is_active'] as bool,
      assignedBranch: (json['assigned_branch'] as List<dynamic>)
          .map((e) => SystemUserBranchModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSuperAdmin: json['is_super_admin'] as bool? ?? false,
      authorizations: json['authorizations'] == null
          ? const []
          : AuthUserModel._authFromJson(json['authorizations'] as List),
    );

Map<String, dynamic> _$AuthUserModelToJson(AuthUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'full_name': instance.fullName,
      'is_active': instance.isActive,
      'is_super_admin': instance.isSuperAdmin,
      'assigned_branch': instance.assignedBranch,
      'authorizations': AuthUserModel._authToJson(instance.authorizations),
    };
