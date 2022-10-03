import 'package:json_annotation/json_annotation.dart';

part 'model.g.dart';

@JsonSerializable()
class PaginationBaseModel {
  int total;
  int page;
  int size;
  Map<String, dynamic> links;

  @JsonKey(name: "first_page")
  int firstPage;

  @JsonKey(name: "last_page")
  int lastPage;
  @JsonKey(name: "prev_page")
  int? prevPage;
  @JsonKey(name: "next_page")
  int? nextPage;

  PaginationBaseModel({
    required this.total,
    required this.page,
    required this.size,
    required this.links,
    required this.firstPage,
    required this.lastPage,
    this.prevPage,
    this.nextPage,
  });

  factory PaginationBaseModel.fromJson(Map<String, dynamic> json) =>
      _$PaginationBaseModelFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationBaseModelToJson(this);
}
