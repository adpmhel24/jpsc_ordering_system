import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class MenuGroupModel {
  String code;

  MenuGroupModel({
    required this.code,
  });

  factory MenuGroupModel.fromJson(Map<String, dynamic> json) =>
      _$MenuGroupModelFromJson(json);

  Map<String, dynamic> toJson() => _$MenuGroupModelToJson(this);
}
