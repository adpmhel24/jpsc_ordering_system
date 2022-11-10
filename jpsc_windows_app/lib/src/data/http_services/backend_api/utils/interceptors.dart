import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

class Logging extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
          'REQUEST[${options.method}] => ${options.baseUrl}${options.path} ${options.queryParameters}');
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'RESPONSE[${response.statusCode}] => ${response.requestOptions.baseUrl}${response.requestOptions.path}',
      );
    }
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    if (kDebugMode) {
      debugPrint(
        'ERROR[${err.response?.statusCode}] => ${err.requestOptions.baseUrl}${err.requestOptions.path}',
      );
    }
    return super.onError(err, handler);
  }
}
