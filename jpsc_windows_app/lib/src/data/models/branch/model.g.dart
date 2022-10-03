// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BranchModel _$BranchModelFromJson(Map<String, dynamic> json) => BranchModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      isActive: json['is_active'] as bool,
    )
      ..pricelistCode = json['pricelist_code'] as String?
      ..pricelist = json['pricelist'] == null
          ? null
          : PricelistModel.fromJson(json['pricelist'] as Map<String, dynamic>);

Map<String, dynamic> _$BranchModelToJson(BranchModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'is_active': instance.isActive,
      'pricelist_code': instance.pricelistCode,
      'pricelist': instance.pricelist,
    };
