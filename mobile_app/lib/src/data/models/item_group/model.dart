import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class ItemGroupModel {
  String code;
  String? description;

  @JsonKey(name: "is_active")
  bool isActive;

  ItemGroupModel({
    required this.code,
    this.description,
    required this.isActive,
  });

  factory ItemGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ItemGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemGroupModelToJson(this);
}
