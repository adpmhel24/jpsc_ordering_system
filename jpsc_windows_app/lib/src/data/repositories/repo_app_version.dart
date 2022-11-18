import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class AppVersionRepo {
  SharedPreferences localStorage;

  final _api = baseAPI;
  List<AppVersionModel> _datas = [];
  List<AppVersionModel> get datas => _datas;

  AppVersionModel? _appVersion;
  final String _urlPath = ConstantURLPath.appVersion;

  AppVersionModel? get appVersion => _appVersion;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  AppVersionRepo({required this.localStorage});

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response =
        await _api.formDataPost(_token, urlPath: "$_urlPath/", data: data);
    return response.data['message'];
  }

  Future<void> getAll() async {
    Response response;

    response = await _api.getAll(_token, urlPath: "$_urlPath/");
    _datas = List<AppVersionModel>.from(
        response.data['data'].map((e) => AppVersionModel.fromJson(e))).toList();
  }
}
