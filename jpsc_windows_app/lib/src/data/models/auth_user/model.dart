import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class AuthUserModel {
  final int id;

  @JsonKey(name: "full_name")
  final String? fullName;

  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "assigned_branch")
  List<SystemUserBranchModel> assignedBranch;

  AuthUserModel({
    required this.id,
    this.fullName = '',
    required this.isActive,
    required this.assignedBranch,
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}
