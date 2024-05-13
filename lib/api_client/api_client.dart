import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

class Api {
  final Dio _dio = Dio();

  Future<Response<T>> client<T>(
    RequestOptions options,
  ) async {
    try {
      final response = await _dio.request<T>(options.path,
          data: options.data,
          queryParameters: options.queryParameters,
          options: Options(
            headers: options.headers,
            method: options.method,
          ));
      return response;
    } catch (e) {
      if (e is DioException) {
        if (e.response?.statusCode == 401) {
          debugPrint("Error 401");
        }
        if (e.response?.statusCode == 404) {
          debugPrint("Error 404");
        }
        if (e.response!.statusCode! >= 500) {
          debugPrint("Error 500");
        }
      }
      return Future.error(e);
    }
  }
}
