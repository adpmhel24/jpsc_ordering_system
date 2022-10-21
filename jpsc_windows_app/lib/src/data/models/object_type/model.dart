import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class ObjectTypeModel {
  final int id;

  final String name;

  @JsonKey(name: "menu_group_code")
  final String menuGroupCode;

  ObjectTypeModel({
    required this.id,
    required this.name,
    required this.menuGroupCode,
  });

  factory ObjectTypeModel.fromJson(Map<String, dynamic> json) =>
      _$ObjectTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ObjectTypeModelToJson(this);
}
