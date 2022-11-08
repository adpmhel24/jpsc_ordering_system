import 'package:freezed_annotation/freezed_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class AuthItemGroupModel {
  int id;

  @JsonKey(name: "system_user_id")
  int systemUserId;

  @JsonKey(name: "item_group_code")
  String itemGroupCode;

  @JsonKey(name: "grant_last_purc")
  bool grantLastPurc;

  @JsonKey(name: "grant_avg_value")
  bool grantAvgValue;

  @JsonKey(name: "date_updated")
  DateTime? dateUpdated;

  @JsonKey(name: "updated_by")
  int? updatedBy;

  AuthItemGroupModel({
    required this.id,
    required this.systemUserId,
    required this.itemGroupCode,
    required this.grantLastPurc,
    required this.grantAvgValue,
    this.dateUpdated,
    this.updatedBy,
  });

  factory AuthItemGroupModel.fromJson(Map<String, dynamic> json) =>
      _$AuthItemGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthItemGroupModelToJson(this);
}
