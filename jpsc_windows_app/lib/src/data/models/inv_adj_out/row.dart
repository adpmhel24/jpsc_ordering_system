import 'package:json_annotation/json_annotation.dart';

part 'row.g.dart';

@JsonSerializable()
class InventoryAdjustmentOutRow {
  int? id;

  @JsonKey(name: "doc_id")
  int? docId;

  @JsonKey(name: "item_code")
  String itemCode;

  @JsonKey(name: "item_description")
  String? itemDescription;

  String whsecode;

  double quantity;

  String uom;
  InventoryAdjustmentOutRow({
    this.id,
    this.docId,
    required this.itemCode,
    this.itemDescription,
    required this.whsecode,
    required this.quantity,
    required this.uom,
  });

  factory InventoryAdjustmentOutRow.fromJson(Map<String, dynamic> json) =>
      _$InventoryAdjustmentOutRowFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryAdjustmentOutRowToJson(this);
}
