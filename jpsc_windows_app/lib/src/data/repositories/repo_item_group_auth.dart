import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';

class ItemGroupAuthRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.itemGroupAuth;

  ItemGroupAuthRepo({required this.localStorage});

  get _token {
    return "${localStorage.getString('access_token')}";
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
