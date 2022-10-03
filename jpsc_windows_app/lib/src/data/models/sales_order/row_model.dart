import 'package:json_annotation/json_annotation.dart';

part 'row_model.g.dart';

@JsonSerializable()
class SalesOrderRowModel {
  int id;

  @JsonKey(name: "item_code")
  String itemCode;

  @JsonKey(name: "item_description")
  String? itemDescription;

  double quantity;

  @JsonKey(name: "srp_price")
  double srpPrice;

  @JsonKey(name: "unit_price")
  double unitPrice;

  String uom;

  @JsonKey(name: "doc_id")
  int docId;

  double linetotal;

  SalesOrderRowModel({
    required this.id,
    required this.itemCode,
    this.itemDescription,
    required this.quantity,
    required this.srpPrice,
    required this.unitPrice,
    required this.uom,
    required this.docId,
    required this.linetotal,
  });

  factory SalesOrderRowModel.fromJson(Map<String, dynamic> json) =>
      _$SalesOrderRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$SalesOrderRowModelToJson(this);

  @override
  String toString() {
    return "$itemCode ($quantity $uom x $unitPrice)";
  }
}
