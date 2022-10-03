import 'dart:io';

import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http_services/backend_api/base_api.dart';
import '../http_services/backend_api/utils/constant_url_path.dart';
import '../models/models.dart';

class InvAdjustmentInRepo {
  SharedPreferences localStorage;
  final api = baseAPI;
  final String urlPath = ConstantURLPath.invAdjIn;

  InvAdjustmentInRepo({
    required this.localStorage,
  });

  List<InventoryAdjustmentInModel> _datas = [];
  List<InventoryAdjustmentInModel> get datas => _datas;

  get _token {
    return "${localStorage.getString('access_token')}";
  }

  Future<void> getAll({Map<String, dynamic>? params}) async {
    Response response;

    response = await api.getAll(
      _token,
      urlPath: urlPath,
      params: params,
    );
    _datas = List<InventoryAdjustmentInModel>.from(response.data['data']
        .map((e) => InventoryAdjustmentInModel.fromJson(e))).toList();
  }

  Future<String> create(Map<String, dynamic> data) async {
    Response response;

    response = await api.create(
      _token,
      urlPath: urlPath,
      data: data,
    );

    return response.data['message'];
  }

  Future<String> update({
    required String fk,
    required Map<String, dynamic> data,
  }) async {
    Response response;

    response = await api.update(
      _token,
      urlPath: "$urlPath$fk",
      data: data,
    );
    return response.data['message'];
  }

  Future<InventoryAdjustmentInModel> getDetails({
    required int fk,
  }) async {
    Response response;
    try {
      response = await api.getByFk(
        _token,
        urlPath: urlPath,
        fk: fk.toString(),
      );
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return InventoryAdjustmentInModel.fromJson(response.data['data']);
  }

  Future<String> cancel({
    required int fk,
    required String canceledRemarks,
  }) async {
    Response response;
    try {
      response = await api.cancel(
        _token,
        urlPath: "${urlPath}cancel/",
        fk: fk.toString(),
        data: {"canceledRemarks": canceledRemarks},
      );
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
    return response.data['message'];
  }
}
