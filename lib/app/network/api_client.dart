import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:ezy_shop/app/network/environment.dart';
import 'package:ezy_shop/app/utils/constants.dart';

class ApiClient {
  ApiClient._();
  static final ApiClient instance = ApiClient._internal();

  late Dio _dio;

  ApiClient._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: getBaseUrl(),
        connectTimeout: Duration(milliseconds: AppConstants.connectTimeout),
        receiveTimeout: Duration(milliseconds: AppConstants.receiveTimeout),
        contentType: "application/json",
      ),
    );

    _dio.interceptors.add(_setupInterceptors());
  }

  InterceptorsWrapper _setupInterceptors() {
    return InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          // Check internet connectivity
          final connectivity = await Connectivity().checkConnectivity();
          if (connectivity == ConnectivityResult.none) {
            throw DioException(
              requestOptions: options,
              error: "No internet connection",
            );
          }

          if (_isJwtTokenRequired(options.path)) {
            // final token = await storage.read(key: StorageKeys.jwtToken);
            // if (token != null) {
            //   options.headers["Authorization"] = "Bearer $token";
            // }
          }

          options.headers["Content-Type"] = "application/json";
          handler.next(options);
        } catch (e) {
          handler.reject(
            DioException(requestOptions: options, error: e.toString()),
          );
        }
      },
      onError: (error, handler) {
        log("API Error: ${error.message}");
        handler.next(error);
      },
    );
  }

  Future<Response?> _requestHandler(
    Future<Response> Function() request,
  ) async {
    try {
      final response = await request();
      return response;
    } on DioException catch (e) {
      log("Dio Error: ${e.message}");
      throw _parseError(e);
    } catch (e) {
      log("Unhandled Error: $e");
      throw Exception("Something went wrong. Please try again.");
    }
  }

  Future<Response?> get(
    String url, {
    Map<String, dynamic>? queryParams,
  }) =>
      _requestHandler(() => _dio.get(url, queryParameters: queryParams));

  Future<Response?> post(
    String url, {
    Map<String, dynamic>? data,
  }) =>
      _requestHandler(() => _dio.post(url, data: data));

  Future<Response?> put(
    String url, {
    Map<String, dynamic>? data,
  }) =>
      _requestHandler(() => _dio.put(url, data: data));

  Future<Response?> delete(String url) =>
      _requestHandler(() => _dio.delete(url));

  bool _isJwtTokenRequired(String path) {
    return true;
  }

  String _parseError(DioException e) {
    if (e.response?.data != null) {
      return e.response?.data["message"] ?? "Unknown server error";
    }
    return e.message ?? "Unknown error occurred";
  }
}
