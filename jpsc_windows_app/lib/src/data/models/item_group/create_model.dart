import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'create_model.g.dart';

@JsonSerializable()
class CreateItemGroupModel extends ItemGroupBaseModel {
  CreateItemGroupModel({
    required super.code,
    super.description,
    required super.isActive,
  });

  factory CreateItemGroupModel.fromJson(Map<String, dynamic> json) =>
      _$CreateItemGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$CreateItemGroupModelToJson(this);
}
