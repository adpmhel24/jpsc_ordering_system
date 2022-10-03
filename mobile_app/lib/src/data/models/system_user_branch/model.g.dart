// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SystemUserBranchModel _$SystemUserBranchModelFromJson(
        Map<String, dynamic> json) =>
    SystemUserBranchModel(
      id: json['id'] as int?,
      systemUserId: json['system_user_id'] as int,
      branchCode: json['branch_code'] as String,
      isAssigned: json['is_assigned'] as bool,
    );

Map<String, dynamic> _$SystemUserBranchModelToJson(
        SystemUserBranchModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'system_user_id': instance.systemUserId,
      'branch_code': instance.branchCode,
      'is_assigned': instance.isAssigned,
    };
