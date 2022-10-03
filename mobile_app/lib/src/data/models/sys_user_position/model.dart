import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class SystemUserPositionModel {
  String code;
  String description;

  SystemUserPositionModel({
    required this.code,
    required this.description,
  });

  factory SystemUserPositionModel.fromJson(Map<String, dynamic> json) =>
      _$SystemUserPositionModelFromJson(json);

  Map<String, dynamic> toJson() => _$SystemUserPositionModelToJson(this);
}
