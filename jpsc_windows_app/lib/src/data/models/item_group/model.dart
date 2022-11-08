import 'package:json_annotation/json_annotation.dart';

import 'base_model.dart';

part 'model.g.dart';

@JsonSerializable()
class ItemGroupModel extends ItemGroupBaseModel {
  ItemGroupModel({
    required super.code,
    super.description,
    required super.isActive,
  });

  factory ItemGroupModel.fromJson(Map<String, dynamic> json) =>
      _$ItemGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$ItemGroupModelToJson(this);
}
