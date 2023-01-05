import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class SystemUserBranchRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String _urlPath = ConstantURLPath.systemUser;

  SystemUserBranchRepo({
    required this.localStorage,
  });

  List<SystemUserBranchModel> _datas = [];
  List<SystemUserBranchModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAssignedBranchesByEmail(String email) async {
    Response response;

    response = await api.get(
      token: _token,
      pathUrl: "$_urlPath/by_email/$email",
    );
    _datas = List<SystemUserBranchModel>.from(
            response.data['data'].map((e) => SystemUserBranchModel.fromJson(e)))
        .toList();
  }

  Future<List<String>> getAssignedBranches(int userId) async {
    Response response;

    response = await api.get(
      token: _token,
      pathUrl: "$_urlPath$userId",
    );
    _datas = List<SystemUserBranchModel>.from(
            response.data['data'].map((e) => SystemUserBranchModel.fromJson(e)))
        .toList();
    return _datas.map((e) => e.branchCode).toList();
  }

  List<String> currentUserBranch() {
    List strBranches =
        json.decode(localStorage.getString("currUserBranch") ?? "");

    return strBranches
        .where((branch) => branch['is_assigned'])
        .map((e) => SystemUserBranchModel.fromJson(e).branchCode)
        .toList();
  }

  Future<String> updateAssignedBranch({
    required List<Map<String, dynamic>> datas,
  }) async {
    Response response;

    response = await api.bulkUpdate(
      _token,
      pathUrl: _urlPath,
      datas: datas,
    );
    return response.data['message'];
  }
}
