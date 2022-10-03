import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class SystemUserRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String _urlPath = ConstantURLPath.systemUser;

  late List<SystemUserModel> _datas = [];

  List<SystemUserModel> get datas => _datas;

  SystemUserRepo({
    required this.localStorage,
  });

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(_token, pathUrl: _urlPath, data: data);
    return response.data['message'];
  }

  Future<String> update(
      {required int id, required Map<String, dynamic> data}) async {
    Response response;

    response =
        await api.update(_token, pathUrl: _urlPath + id.toString(), data: data);
    return response.data['message'];
  }

  Future<void> getAllSystemUser({Map<String, dynamic>? params}) async {
    Response response;

    try {
      response = await api.getAll(_token, pathUrl: _urlPath, params: params);
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
}
