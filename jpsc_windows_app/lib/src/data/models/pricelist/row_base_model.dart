import 'package:json_annotation/json_annotation.dart';

abstract class PricelistRowBaseModel {
  static toNull(_) => null;
  int? id;

  @JsonKey(name: "pricelist_code")
  String pricelistCode;

  @JsonKey(name: "item_code")
  String itemCode;

  @JsonKey(name: "last_purchase_price")
  double lastPurchasedPrice;
  @JsonKey(name: "avg_sap_value")
  double avgSapValue;
  @JsonKey(name: "logistics_cost")
  double logisticsCost;

  double profit;

  double price;

  @JsonKey(name: "uom_code")
  String uomCode;

  @JsonKey(name: "date_updated")
  DateTime? dateUpdated;

  // @JsonKey(toJson: toNull)
  // ProductModel? item;

  // @JsonKey(name: "updated_by_user")
  // SystemUserModel? updatedByUser;

  PricelistRowBaseModel({
    required this.pricelistCode,
    required this.itemCode,
    required this.lastPurchasedPrice,
    required this.avgSapValue,
    required this.logisticsCost,
    required this.profit,
    required this.price,
    required this.uomCode,
    this.id,
    this.dateUpdated,
  });
}
