import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class ProductBaseModel {
  String code;
  String? description;

  @JsonKey(name: "item_group_code")
  String? itemGroupCode;

  @JsonKey(name: "sale_uom_code")
  String? saleUomCode;

  String? barcode;

  ProductBaseModel({
    required this.code,
    this.description,
    this.itemGroupCode,
    this.saleUomCode,
    this.barcode,
  });
}
