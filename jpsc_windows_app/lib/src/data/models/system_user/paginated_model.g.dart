// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PaginatedSystemUserModel _$PaginatedSystemUserModelFromJson(
        Map<String, dynamic> json) =>
    PaginatedSystemUserModel(
      data: (json['data'] as List<dynamic>)
          .map((e) => SystemUserModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      total: json['total'] as int,
      page: json['page'] as int,
      size: json['size'] as int,
      links: json['links'] as Map<String, dynamic>,
      firstPage: json['first_page'] as int,
      lastPage: json['last_page'] as int,
    )
      ..prevPage = json['prev_page'] as int?
      ..nextPage = json['next_page'] as int?;

Map<String, dynamic> _$PaginatedSystemUserModelToJson(
        PaginatedSystemUserModel instance) =>
    <String, dynamic>{
      'total': instance.total,
      'page': instance.page,
      'size': instance.size,
      'links': instance.links,
      'first_page': instance.firstPage,
      'last_page': instance.lastPage,
      'prev_page': instance.prevPage,
      'next_page': instance.nextPage,
      'data': instance.data,
    };
