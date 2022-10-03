import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class UomModel {
  String code;
  String? description;

  @JsonKey(name: "is_active")
  bool isActive;

  UomModel({
    required this.code,
    this.description,
    required this.isActive,
  });

  factory UomModel.fromJson(Map<String, dynamic> json) =>
      _$UomModelFromJson(json);

  Map<String, dynamic> toJson() => _$UomModelToJson(this);
}
