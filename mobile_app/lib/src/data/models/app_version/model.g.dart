// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppVersionModel _$AppVersionModelFromJson(Map<String, dynamic> json) =>
    AppVersionModel(
      id: json['id'] as int,
      platform: json['platform'] as String,
      appName: json['app_name'] as String,
      packageName: json['package_name'] as String,
      version: json['version'] as String,
      buildNumber: json['build_number'] as int,
      link: json['link'] as String?,
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$AppVersionModelToJson(AppVersionModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'platform': instance.platform,
      'app_name': instance.appName,
      'package_name': instance.packageName,
      'version': instance.version,
      'build_number': instance.buildNumber,
      'link': instance.link,
      'is_active': instance.isActive,
    };
