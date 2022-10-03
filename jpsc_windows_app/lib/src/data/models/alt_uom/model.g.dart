// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AltUomModel _$AltUomModelFromJson(Map<String, dynamic> json) => AltUomModel(
      id: json['id'] as int,
      uomGroupCode: json['uom_group_code'] as String,
      altQty: (json['alt_qty'] as num).toDouble(),
      altUom: json['alt_uom'] as String,
      baseQty: (json['base_qty'] as num).toDouble(),
      baseUom: json['base_uom'] as String,
    );

Map<String, dynamic> _$AltUomModelToJson(AltUomModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'uom_group_code': instance.uomGroupCode,
      'alt_qty': instance.altQty,
      'alt_uom': instance.altUom,
      'base_qty': instance.baseQty,
      'base_uom': instance.baseUom,
    };
