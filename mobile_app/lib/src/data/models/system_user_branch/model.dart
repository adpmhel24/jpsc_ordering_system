import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class SystemUserBranchModel {
  int? id;

  @JsonKey(name: "system_user_id")
  int systemUserId;

  @JsonKey(name: "branch_code")
  String branchCode;

  @JsonKey(name: "is_assigned")
  bool isAssigned;

  SystemUserBranchModel({
    this.id,
    required this.systemUserId,
    required this.branchCode,
    required this.isAssigned,
  });

  factory SystemUserBranchModel.fromJson(Map<String, dynamic> json) =>
      _$SystemUserBranchModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserBranchModelToJson(this);
}
