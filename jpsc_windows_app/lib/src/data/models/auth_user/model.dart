import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class AuthUserModel {
  static List<AuthorizationModel> _authFromJson(List<dynamic> data) {
    if (data.isNotEmpty) {
      return data.map((e) => AuthorizationModel.fromJson(e!)).toList();
    } else {
      return [];
    }
  }

  static List<Map<String, dynamic>>? _authToJson(
      List<AuthorizationModel> rows) {
    if (rows.isNotEmpty) {
      return rows.map((e) => e.toJson()).toList();
    }
    return [];
  }

  final int id;

  @JsonKey(name: "full_name")
  final String? fullName;

  @JsonKey(name: "is_active")
  final bool isActive;

  @JsonKey(name: "is_super_admin")
  final bool isSuperAdmin;

  @JsonKey(name: "assigned_branch")
  List<SystemUserBranchModel> assignedBranch;

  @JsonKey(fromJson: _authFromJson, toJson: _authToJson)
  List<AuthorizationModel> authorizations;

  AuthUserModel({
    required this.id,
    this.fullName = '',
    required this.isActive,
    required this.assignedBranch,
    this.isSuperAdmin = false,
    this.authorizations = const [],
  });

  factory AuthUserModel.fromJson(Map<String, dynamic> json) =>
      _$AuthUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthUserModelToJson(this);
}
