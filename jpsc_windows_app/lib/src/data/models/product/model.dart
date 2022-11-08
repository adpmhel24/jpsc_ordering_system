import 'package:jpsc_windows_app/src/data/models/product/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class ProductModel extends ProductBaseModel {
  @JsonKey(name: "is_active")
  bool isActive;

  @JsonKey(name: "item_group")
  ItemGroupModel? itemGroup;

  @JsonKey(name: "uom_group")
  UomGroupModel? uomGroup;

  double? price;

  ProductModel({
    required super.code,
    super.description,
    super.itemGroupCode,
    super.saleUomCode,
    super.barcode,
    required this.isActive,
    this.itemGroup,
    this.uomGroup,
    this.price,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) =>
      _$ProductModelFromJson(json);

  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}
