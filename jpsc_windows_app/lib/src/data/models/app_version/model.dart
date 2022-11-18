import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class AppVersionModel {
  int id;
  String platform;
  @JsonKey(name: "app_name")
  String appName;
  @JsonKey(name: "package_name")
  String packageName;
  String version;
  @JsonKey(name: "build_number")
  int buildNumber;

  String? link;
  @JsonKey(name: "is_active")
  bool isActive;

  AppVersionModel(
      {required this.id,
      required this.platform,
      required this.appName,
      required this.packageName,
      required this.version,
      required this.buildNumber,
      this.link,
      required this.isActive});
  factory AppVersionModel.fromJson(Map<String, dynamic> json) =>
      _$AppVersionModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppVersionModelToJson(this);
}
