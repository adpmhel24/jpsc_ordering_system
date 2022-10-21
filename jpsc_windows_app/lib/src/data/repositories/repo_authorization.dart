import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class AuthorizationRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.authorization;

  AuthorizationRepo({required this.localStorage});

  List<AuthorizationModel> _datas = [];
  List<AuthorizationModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll() async {
    Response response;

    response = await api.getAll(_token, urlPath: urlPath);
    _datas = List<AuthorizationModel>.from(
            response.data['data'].map((e) => AuthorizationModel.fromJson(e)))
        .toList();
  }

  Future<String> bulkUpdate({required List<Map<String, dynamic>> datas}) async {
    Response response;

    response = await api.bulkUpdate(
      _token,
      urlPath: "${urlPath}bulk_update",
      datas: datas,
    );
    return response.data['message'];
  }
}
