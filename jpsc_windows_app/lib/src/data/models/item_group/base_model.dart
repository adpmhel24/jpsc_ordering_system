import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
abstract class ItemGroupBaseModel {
  String code;
  String? description;

  @JsonKey(name: "is_active")
  bool isActive;

  ItemGroupBaseModel({
    required this.code,
    this.description,
    required this.isActive,
  });
}
