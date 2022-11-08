// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row_log_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PricelistRowLogModel _$PricelistRowLogModelFromJson(
        Map<String, dynamic> json) =>
    PricelistRowLogModel(
      pricelistCode: json['pricelist_code'] as String,
      itemCode: json['item_code'] as String,
      lastPurchasedPrice: (json['last_purchase_price'] as num).toDouble(),
      avgSapValue: (json['avg_sap_value'] as num).toDouble(),
      logisticsCost: (json['logistics_cost'] as num).toDouble(),
      profit: (json['profit'] as num).toDouble(),
      price: (json['price'] as num).toDouble(),
      uomCode: json['uom_code'] as String,
      dateUpdated: json['date_updated'] == null
          ? null
          : DateTime.parse(json['date_updated'] as String),
      id: json['id'] as int?,
      item: json['item'] == null
          ? null
          : ProductModel.fromJson(json['item'] as Map<String, dynamic>),
      updatedByUser: json['updated_by_user'] == null
          ? null
          : SystemUserModel.fromJson(
              json['updated_by_user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PricelistRowLogModelToJson(
        PricelistRowLogModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'pricelist_code': instance.pricelistCode,
      'item_code': instance.itemCode,
      'last_purchase_price': instance.lastPurchasedPrice,
      'avg_sap_value': instance.avgSapValue,
      'logistics_cost': instance.logisticsCost,
      'profit': instance.profit,
      'price': instance.price,
      'uom_code': instance.uomCode,
      'date_updated': instance.dateUpdated?.toIso8601String(),
      'updated_by_user': instance.updatedByUser,
      'item': PricelistRowLogModel.toNull(instance.item),
    };
