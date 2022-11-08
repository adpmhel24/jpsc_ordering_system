import 'package:json_annotation/json_annotation.dart';

import '../models.dart';
import 'base_model.dart';

part 'model.g.dart';

@JsonSerializable()
class SystemUserModel extends SystemUserBaseModel {
  int id;

  @JsonKey(name: "assigned_branch")
  List<SystemUserBranchModel> assignedBranch;

  SystemUserModel({
    required this.id,
    required super.email,
    super.firstName = '',
    super.lastName = '',
    super.positionCode,
    this.assignedBranch = const [],
    required super.isActive,
    required super.isSuperAdmin,
  });

  factory SystemUserModel.fromJson(Map<String, dynamic> json) =>
      _$SystemUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserModelToJson(this);
}
