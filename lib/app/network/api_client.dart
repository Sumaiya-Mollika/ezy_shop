import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:ezy_shop/app/network/environment.dart';


class DioClient {
  static Dio? _dio;

  static Dio get dio {
    if (_dio == null) {
      _dio = Dio();
      _dio!.options = BaseOptions(
        baseUrl: getBaseUrl(),
        contentType: "application/json",
      );
      _dio!.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
        //   _token="";
        //   if (_token != null && _token!.isNotEmpty) {
        //   options.headers['Authorization'] = 'Bearer $_token';
        // }
          if (_dio!.options.headers.containsKey('Authorization')) {
            options.headers.addAll(_dio!.options.headers);
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

