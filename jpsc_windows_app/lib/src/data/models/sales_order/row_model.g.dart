// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesOrderRowModel _$SalesOrderRowModelFromJson(Map<String, dynamic> json) =>
    SalesOrderRowModel(
      id: json['id'] as int,
      itemCode: json['item_code'] as String,
      itemDescription: json['item_description'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      srpPrice: (json['srp_price'] as num).toDouble(),
      unitPrice: (json['unit_price'] as num).toDouble(),
      uom: json['uom'] as String,
      docId: json['doc_id'] as int,
      linetotal: (json['linetotal'] as num).toDouble(),
    );

Map<String, dynamic> _$SalesOrderRowModelToJson(SalesOrderRowModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'item_code': instance.itemCode,
      'item_description': instance.itemDescription,
      'quantity': instance.quantity,
      'srp_price': instance.srpPrice,
      'unit_price': instance.unitPrice,
      'uom': instance.uom,
      'doc_id': instance.docId,
      'linetotal': instance.linetotal,
    };
