import 'package:json_annotation/json_annotation.dart';

import '../models.dart';

part 'model.g.dart';

@JsonSerializable()
class AuthorizationModel {
  static ObjectTypeModel? _fromJson(Map<String, dynamic>? data) {
    if (data != null) {
      return ObjectTypeModel.fromJson(data);
    } else {
      return null;
    }
  }

  static Map<String, dynamic>? _toJson(ObjectTypeModel? row) {
    if (row != null) {
      return row.toJson();
    }
    return null;
  }

  final int id;

  @JsonKey(name: "system_user_id")
  int systemUserId;

  int objtype;

  bool full;
  bool read;
  bool create;
  bool approve;
  bool update;

  @JsonKey(name: "object_type_obj", fromJson: _fromJson, toJson: _toJson)
  final ObjectTypeModel? objectTypeObj;

  AuthorizationModel({
    required this.id,
    required this.systemUserId,
    required this.objtype,
    required this.full,
    required this.read,
    required this.create,
    required this.approve,
    required this.update,
    this.objectTypeObj,
  });

  factory AuthorizationModel.fromJson(Map<String, dynamic> json) =>
      _$AuthorizationModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthorizationModelToJson(this);
}
