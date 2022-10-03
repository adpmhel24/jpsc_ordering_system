import 'dart:io';

import 'package:dio/dio.dart';

import '../backend_api/utils/interceptors.dart';

class PhLocationApiService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: 'https://psgc.gitlab.io/api',
    ),
  )..interceptors.add(Logging());

  Future<Response> fetchData(String path) async {
    Response response;
    try {
      response = await _dio.get(path);
    } on DioError catch (e) {
      if (e.response != null) {
        throw HttpException(e.response!.data['message']);
      } else if (e.type == DioErrorType.connectTimeout) {
        throw const HttpException("Connection timed out");
      } else {
        throw HttpException(e.message);
      }
    }
    return response;
  }
}
