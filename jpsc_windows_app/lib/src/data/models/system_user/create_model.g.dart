// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateSystemUserModel _$CreateSystemUserModelFromJson(
        Map<String, dynamic> json) =>
    CreateSystemUserModel(
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      isActive: json['is_active'] as bool,
      isSuperAdmin: json['is_super_admin'] as bool,
      positionCode: json['position_code'] as String?,
      password: json['password'] as String,
    );

Map<String, dynamic> _$CreateSystemUserModelToJson(
        CreateSystemUserModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'is_active': instance.isActive,
      'is_super_admin': instance.isSuperAdmin,
      'position_code': instance.positionCode,
      'password': instance.password,
    };
