// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateProductModel _$CreateProductModelFromJson(Map<String, dynamic> json) =>
    CreateProductModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      itemGroupCode: json['item_group_code'] as String?,
      saleUomCode: json['sale_uom_code'] as String?,
      barcode: json['barcode'] as String?,
    );

Map<String, dynamic> _$CreateProductModelToJson(CreateProductModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'item_group_code': instance.itemGroupCode,
      'sale_uom_code': instance.saleUomCode,
      'barcode': instance.barcode,
    };
