// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CartItemModel _$CartItemModelFromJson(Map<String, dynamic> json) =>
    CartItemModel(
      id: json['id'] as String?,
      itemCode: json['item_code'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      srpPrice: (json['srp_price'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      uom: json['uom'] as String,
      total: (json['total'] as num).toDouble(),
    );

Map<String, dynamic> _$CartItemModelToJson(CartItemModel instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('id', CartItemModel.toNull(instance.id));
  val['item_code'] = instance.itemCode;
  val['quantity'] = instance.quantity;
  val['srp_price'] = instance.srpPrice;
  val['unit_price'] = instance.unitPrice;
  val['uom'] = instance.uom;
  writeNotNull('total', CartItemModel.toNull(instance.total));
  return val;
}
