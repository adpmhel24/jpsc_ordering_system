import 'package:freezed_annotation/freezed_annotation.dart';

import '../models.dart';
import 'row_base_model.dart';

part 'row_log_model.g.dart';

@JsonSerializable()
class PricelistRowLogModel extends PricelistRowBaseModel {
  static toNull(_) => null;

  @JsonKey(name: "updated_by_user")
  SystemUserModel? updatedByUser;

  @JsonKey(toJson: toNull)
  ProductModel? item;

  PricelistRowLogModel({
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
    this.updatedByUser,
  });

  factory PricelistRowLogModel.fromJson(Map<String, dynamic> json) =>
      _$PricelistRowLogModelFromJson(json);

  Map<String, dynamic> toJson() => _$PricelistRowLogModelToJson(this);
}
