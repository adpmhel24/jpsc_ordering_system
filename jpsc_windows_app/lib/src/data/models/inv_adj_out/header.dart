import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'header.g.dart';

@JsonSerializable()
class InventoryAdjustmentOutHeader {
  int id;
  String reference;
  String docstatus;
  DateTime transdate;

  @JsonKey(name: "date_created")
  DateTime dateCreated;

  @JsonKey(name: "created_by_user")
  SystemUserModel createdBy;

  @JsonKey(name: "date_updated")
  DateTime? dateUpdated;

  @JsonKey(name: "updated_by_user")
  SystemUserModel? updatedBy;

  String? remarks;

  InventoryAdjustmentOutHeader({
    required this.id,
    required this.reference,
    required this.docstatus,
    required this.transdate,
    required this.dateCreated,
    required this.createdBy,
    this.updatedBy,
    this.dateUpdated,
    this.remarks,
  });

  factory InventoryAdjustmentOutHeader.fromJson(Map<String, dynamic> json) =>
      _$InventoryAdjustmentOutHeaderFromJson(json);

  Map<String, dynamic> toJson() => _$InventoryAdjustmentOutHeaderToJson(this);
}
