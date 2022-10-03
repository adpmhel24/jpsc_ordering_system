// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WarehouseModel _$WarehouseModelFromJson(Map<String, dynamic> json) =>
    WarehouseModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
      branchCode: json['branch_code'] as String?,
      branch: json['branch'] == null
          ? null
          : BranchModel.fromJson(json['branch'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WarehouseModelToJson(WarehouseModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'branch_code': instance.branchCode,
      'branch': instance.branch,
      'is_active': instance.isActive,
    };
