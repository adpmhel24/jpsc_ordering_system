import 'package:json_annotation/json_annotation.dart';

part 'row_model.g.dart';

@JsonSerializable()
class PricelistRowModel {
  int id;

  @JsonKey(name: "pricelist_code")
  String pricelistCode;

  @JsonKey(name: "item_code")
  String itemCode;

  double price;

  @JsonKey(name: "uom_code")
  String uomCode;

  PricelistRowModel({
    required this.id,
    required this.pricelistCode,
    required this.itemCode,
    required this.price,
    required this.uomCode,
  });

  factory PricelistRowModel.fromJson(Map<String, dynamic> json) =>
      _$PricelistRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricelistRowModelToJson(this);
}
