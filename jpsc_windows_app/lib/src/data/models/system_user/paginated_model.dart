import 'package:json_annotation/json_annotation.dart';
import '../models.dart';

part 'paginated_model.g.dart';

@JsonSerializable()
class PaginatedSystemUserModel extends PaginationBaseModel {
  List<SystemUserModel> data;
  PaginatedSystemUserModel({
    required this.data,
    required int total,
    required int page,
    required int size,
    required Map<String, dynamic> links,
    required int firstPage,
    required int lastPage,
  }) : super(
            total: total,
            page: page,
            size: size,
            links: links,
            firstPage: firstPage,
            lastPage: lastPage);

  factory PaginatedSystemUserModel.fromJson(Map<String, dynamic> json) =>
      _$PaginatedSystemUserModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PaginatedSystemUserModelToJson(this);
}
