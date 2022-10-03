import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class WarehouseModel {
  String code;
  String? description;

  @JsonKey(name: "branch_code")
  String? branchCode;
  BranchModel? branch;

  @JsonKey(name: "is_active")
  bool isActive;

  WarehouseModel({
    required this.code,
    this.description,
    required this.isActive,
    this.branchCode,
    this.branch,
  });

  factory WarehouseModel.fromJson(Map<String, dynamic> json) =>
      _$WarehouseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WarehouseModelToJson(this);
}
