import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class ProductModel {
  String code;
  String? description;

  @JsonKey(name: "item_group_code")
  String? itemGroupCode;

  @JsonKey(name: "sale_uom_code")
  String? saleUomCode;

  @JsonKey(name: "is_active")
  bool isActive;

  String? barcode;

  @JsonKey(name: "item_group")
  ItemGroupModel? itemGroup;

  @JsonKey(name: "uom_group")
  UomGroupModel? uomGroup;

  double? price;

  ProductModel({
    required this.code,
    this.description,
    this.itemGroupCode,
    this.saleUomCode,
    this.barcode,
    required this.isActive,
    this.itemGroup,
    this.uomGroup,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
