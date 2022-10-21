import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class MenuGroupRepo {
  SharedPreferences localStorage;

  MenuGroupRepo({
    required this.localStorage,
  });

  final api = baseAPI;

  final String _urlPath = ConstantURLPath.menuGroup;

  List<MenuGroupModel> _datas = [];
  List<MenuGroupModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(_token, urlPath: _urlPath, params: params);
    _datas = List<MenuGroupModel>.from(
        response.data['data'].map((e) => MenuGroupModel.fromJson(e))).toList();
  }
}
