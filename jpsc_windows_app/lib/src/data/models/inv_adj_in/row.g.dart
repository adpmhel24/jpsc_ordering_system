// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InventoryAdjustmentInRow _$InventoryAdjustmentInRowFromJson(
        Map<String, dynamic> json) =>
    InventoryAdjustmentInRow(
      id: json['id'] as int?,
      docId: json['doc_id'] as int?,
      itemCode: json['item_code'] as String,
      itemDescription: json['item_description'] as String?,
      whsecode: json['whsecode'] as String,
      quantity: (json['quantity'] as num).toDouble(),
      uom: json['uom'] as String,
    );

Map<String, dynamic> _$InventoryAdjustmentInRowToJson(
        InventoryAdjustmentInRow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'doc_id': instance.docId,
      'item_code': instance.itemCode,
      'item_description': instance.itemDescription,
      'whsecode': instance.whsecode,
      'quantity': instance.quantity,
      'uom': instance.uom,
    };
