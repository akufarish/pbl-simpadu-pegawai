import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/services/auth_service.dart';
import 'package:pegawai/utils/token_manager.dart';

class ApiClient {
  ApiClient._internal();
  static final ApiClient _instance = ApiClient._internal();
  factory ApiClient() => _instance;
  final AuthService authService = AuthService();

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

            String? refreshToken = await TokenManager.getRefreshToken();

            if (refreshToken != null && !JwtDecoder.isExpired(refreshToken)) {
              try {
                RefreshTokenRequest refreshTokenRequest = RefreshTokenRequest(
                  refreshToken: refreshToken,
                );

                bool isSuccess = await authService.refreshToken(
                  refreshTokenRequest,
                );

                if (isSuccess) {
                  String? newToken = await TokenManager.getAccessToken();
                  final options = e.requestOptions;
                  options.headers['Authorization'] = 'Bearer $newToken';
                  final response = await dioInstance.fetch(options);
                  return handler.resolve(response);
                }
              } catch (e) {
                debugPrint('Gagal refresh token: $e');
              }
            }
            debugPrint('Refresh token expired');
            await TokenManager.clearToken();
          }
          return handler.next(e);
        },
      ),
    );

    return dioInstance;
  }
}
