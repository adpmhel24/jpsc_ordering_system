import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class SystemUserBranchRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.userBranch;

  SystemUserBranchRepo({
    required this.localStorage,
  });

  List<SystemUserBranchModel> _datas = [];
  List<SystemUserBranchModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAssignedBranches(int userId) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: "$urlPath$userId",
    );
    _datas = List<SystemUserBranchModel>.from(
            response.data['data'].map((e) => SystemUserBranchModel.fromJson(e)))
        .toList();
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
      urlPath: urlPath,
      datas: datas,
    );
    return response.data['message'];
  }
}
