import 'package:dio/dio.dart';
import 'package:mobile_app/src/data/http_services/backend_api/base_api.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class BranchRepo {
  SharedPreferences localStorage;

  BranchRepo({
    required this.localStorage,
  });

  final api = baseAPI;

  final String _urlPath = ConstantURLPath.branch;

  List<BranchModel> _datas = [];
  List<BranchModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll() async {
    Response response;

    response = await api.getAll(_token, pathUrl: _urlPath);
    _datas = List<BranchModel>.from(
        response.data['data'].map((e) => BranchModel.fromJson(e))).toList();
  }

  Future<String> createBranch(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(_token, pathUrl: _urlPath, data: data);
    return response.data['message'];
  }

  Future<String> update(
      {required String branchName, required Map<String, dynamic> data}) async {
    Response response;

    response = await api.update(
      _token,
      pathUrl: _urlPath + branchName,
      data: data,
    );
    return response.data['message'];
  }

  Future<List<BranchModel>> offlineSearch(String value) async {
    Future.delayed(const Duration(seconds: 5));
    if (_datas.isEmpty) {
      await getAll();
    }
    if (value.isNotEmpty) {
      var filtered = _datas
          .where(
            (branch) => branch.code.toLowerCase().contains(
                  value.toLowerCase(),
                ),
          )
          .toList();
      return filtered;
    }
    return datas;
  }
}
