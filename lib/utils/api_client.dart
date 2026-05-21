import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pegawai/utils/token_manager.dart';

class ApiClient {
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;

  late final Dio dio = _initDio();

  Dio _initDio() {
    final dioInstance = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    dioInstance.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          String? token = await TokenManager.getAccessToken();

          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }

          debugPrint('REQUEST[${options.method}] => PATH: ${options.uri}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          if (e.response?.statusCode == 401) {
            debugPrint('Token expired atau tidak valid');
            await TokenManager.clearToken();
          }
          return handler.next(e);
        },
      ),
    );

    return dioInstance;
  }
}
