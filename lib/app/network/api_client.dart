import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ezy_shop/app/network/environment.dart';
import 'package:ezy_shop/app/utils/constants.dart';

class ApiClient {
  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options = BaseOptions(
          baseUrl: getBaseUrl(),
          contentType: "application/json",
          responseType: ResponseType.json);
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await storage.read(StorageKey.token);
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (error, handler) {
          log('Error: $error');
          return handler.next(error);
        },
      ));
      _dio!.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        responseBody: true,
        error: true,
      ));
    }
    return _dio!;
  }

  Future<Response> get(String path, {Map<String, dynamic>? queryParams}) async {
    try {
      return await dio.get(path, queryParameters: queryParams);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> post(String path,
      {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      return await dio.post(path, data: data, queryParameters: queryParams);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> put(String path,
      {dynamic data, Map<String, dynamic>? queryParams}) async {
    try {
      return await dio.put(path, data: data, queryParameters: queryParams);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<Response> delete(String path,
      {Map<String, dynamic>? queryParams}) async {
    try {
      return await dio.delete(path, queryParameters: queryParams);
    } on DioException catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
