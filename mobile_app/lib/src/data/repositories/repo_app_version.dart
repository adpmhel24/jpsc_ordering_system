import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class AppVersionRepo {
  late PackageInfo _packageInfo;
  final _api = baseAPI;
  AppVersionModel? _appVersion;
  final String _urlPath = ConstantURLPath.appVersion;

  PackageInfo get packageInfo => _packageInfo;
  AppVersionModel? get appVersion => _appVersion;

  void init() async {
    _packageInfo = await PackageInfo.fromPlatform();
  }

  Future<bool> hasNewUpdate() async {
    // _packageInfo = await PackageInfo.fromPlatform();

    Response response;

    response = await _api.get(
      pathUrl: "$_urlPath/latest",
      params: {
        "platform": "android",
        "app_name": _packageInfo.appName,
        "package_name": _packageInfo.packageName,
        "is_active": true,
      },
    );
    if (response.data['data'] != null) {
      _appVersion = AppVersionModel.fromJson(response.data['data']);
      return _appVersion!.version != _packageInfo.version ||
          _appVersion!.buildNumber != int.parse(_packageInfo.buildNumber) % 10;
    }
    return false;
  }
}
