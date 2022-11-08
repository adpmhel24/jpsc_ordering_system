import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';
import 'row_base_model.dart';

part 'row_model.g.dart';

@JsonSerializable()
class PricelistRowModel extends PricelistRowBaseModel {
  static toNull(_) => null;

  @JsonKey(toJson: toNull)
  ProductModel? item;

  PricelistRowModel({
    required super.pricelistCode,
    required super.itemCode,
    required super.lastPurchasedPrice,
    required super.avgSapValue,
    required super.logisticsCost,
    required super.profit,
    required super.price,
    required super.uomCode,
    super.dateUpdated,
    super.id,
    this.item,
  });

  factory PricelistRowModel.fromJson(Map<String, dynamic> json) =>
      _$PricelistRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricelistRowModelToJson(this);
}
