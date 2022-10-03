import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'inv_adj_in.g.dart';

@JsonSerializable()
class InventoryAdjustmentInModel extends InventoryAdjustmentInHeader {
  InventoryAdjustmentInModel({
    required super.id,
    required super.reference,
    required super.docstatus,
    required super.transdate,
    required super.dateCreated,
    required super.createdBy,
    required this.rows,
  });

  List<InventoryAdjustmentInRow> rows;

  factory InventoryAdjustmentInModel.fromJson(Map<String, dynamic> json) =>
      _$InventoryAdjustmentInModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$InventoryAdjustmentInModelToJson(this);
}
