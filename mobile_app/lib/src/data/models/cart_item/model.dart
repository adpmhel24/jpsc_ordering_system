import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class CartItemModel {
  static toNull(_) => null;

  @JsonKey(toJson: toNull, includeIfNull: false)
  String? id;
  @JsonKey(name: "item_code")
  String itemCode;

  double quantity;

  @JsonKey(name: "srp_price")
  double srpPrice;

  @JsonKey(name: "unit_price")
  double unitPrice;

  String uom;

  @JsonKey(toJson: toNull, includeIfNull: false)
  double total;

  CartItemModel({
    this.id,
    required this.itemCode,
    required this.quantity,
    required this.srpPrice,
    required this.unitPrice,
    required this.uom,
    required this.total,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) =>
      _$CartItemModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemModelToJson(this);
}
