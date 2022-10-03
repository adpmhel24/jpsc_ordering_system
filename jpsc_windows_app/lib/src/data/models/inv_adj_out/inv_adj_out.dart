import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'inv_adj_out.g.dart';

@JsonSerializable()
class InventoryAdjustmentOutModel extends InventoryAdjustmentInHeader {
  InventoryAdjustmentOutModel({
    required super.id,
    required super.reference,
    required super.docstatus,
    required super.transdate,
    required super.dateCreated,
    required super.createdBy,
    required this.rows,
  });

  List<InventoryAdjustmentOutRow> rows;

  factory InventoryAdjustmentOutModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryAdjustmentOutModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InventoryAdjustmentOutModelToJson(this);
}
