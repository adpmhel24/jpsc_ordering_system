// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricelistRowModel _$PricelistRowModelFromJson(Map<String, dynamic> json) =>
    PricelistRowModel(
      id: json['id'] as int,
      pricelistCode: json['pricelist_code'] as String,
      itemCode: json['item_code'] as String,
      price: (json['price'] as num).toDouble(),
      uomCode: json['uom_code'] as String,
    );

Map<String, dynamic> _$PricelistRowModelToJson(PricelistRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pricelist_code': instance.pricelistCode,
      'item_code': instance.itemCode,
      'price': instance.price,
      'uom_code': instance.uomCode,
    };
