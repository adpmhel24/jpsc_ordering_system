// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductModel _$ProductModelFromJson(Map<String, dynamic> json) => ProductModel(
      code: json['code'] as String,
      description: json['description'] as String?,
      itemGroupCode: json['item_group_code'] as String?,
      saleUomCode: json['sale_uom_code'] as String?,
      barcode: json['barcode'] as String?,
      isActive: json['is_active'] as bool,
      itemGroup: json['item_group'] == null
          ? null
          : ItemGroupModel.fromJson(json['item_group'] as Map<String, dynamic>),
      uomGroup: json['uom_group'] == null
          ? null
          : UomGroupModel.fromJson(json['uom_group'] as Map<String, dynamic>),
      price: (json['price'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$ProductModelToJson(ProductModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'description': instance.description,
      'item_group_code': instance.itemGroupCode,
      'sale_uom_code': instance.saleUomCode,
      'barcode': instance.barcode,
      'is_active': instance.isActive,
      'item_group': instance.itemGroup,
      'uom_group': instance.uomGroup,
      'price': instance.price,
    };
