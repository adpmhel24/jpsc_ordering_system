import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class SystemUserRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.systemUser;

  late List<SystemUserModel> _datas = [];

  List<SystemUserModel> get datas => _datas;

  SystemUserRepo({required this.localStorage});
  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(_token, urlPath: urlPath, data: data);
    return response.data['message'];
  }

  Future<String> update(
      {required int id, required Map<String, dynamic> data}) async {
    Response response;

    response = await api.update(_token, urlPath: "$urlPath$id", data: data);
    return response.data['message'];
  }

  Future<String> bulkInsert({required List<Map<String, dynamic>> datas}) async {
    Response response;

    response = await api.bulkInsert(
      _token,
      urlPath: "${urlPath}bulk_insert",
      datas: datas,
    );
    return response.data['message'];
  }

  Future<String> changePassword(Map<String, dynamic> data) async {
    Response response;

    response = await api.update(
      _token,
      urlPath: "${urlPath}change_password",
      data: data,
    );
    return response.data['message'];
  }

  Future<void> getAllSystemUser({Map<String, dynamic>? params}) async {
    Response response;

    try {
      response = await api.getAll(_token, urlPath: urlPath, params: params);
      _datas = List<SystemUserModel>.from(
        response.data['data'].map(
          (systemUser) {
            return SystemUserModel.fromJson(systemUser);
          },
        ),
      ).toList();
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<List<SystemUserModel>> offlineSearchByKeyword(String value) async {
    if (value.isNotEmpty) {
      return _datas
          .where((e) =>
              e.email.toLowerCase().contains(value.toLowerCase()) ||
              e.firstName.toLowerCase().contains(value.toLowerCase()))
          .toList();
    }
    return _datas;
  }
}
