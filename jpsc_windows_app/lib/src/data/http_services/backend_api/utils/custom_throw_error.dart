import 'dart:io';

import 'package:dio/dio.dart';

class CustomThrowError {
  static HttpException throwError(DioError err) {
    if (err.response != null) {
      if (err.response!.data.runtimeType != String) {
        throw HttpException(err.response!.data['message']);
      } else {
        throw HttpException(
            "Error Code ${err.response!.statusCode}: ${err.response!.statusMessage}");
      }
    } else if (err.type == DioErrorType.connectTimeout) {
      throw const HttpException("Connection timed out");
    } else {
      throw HttpException(err.message);
    }
  }
}
