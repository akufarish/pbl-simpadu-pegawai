import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pegawai/models/api_response.dart';
import 'package:pegawai/models/user.dart';
import 'package:pegawai/utils/api_client.dart';
import 'package:pegawai/utils/token_manager.dart';

class AuthService {
  final String kelompok1Url = dotenv.get("KELOMPOK_1_BASE_URL");

  Future<String?> login(LoginRequest payload) async {
    try {
      final response = await ApiClient().dio.post(
        "$kelompok1Url/api/auth/login",
        data: payload.toJson(),
      );

      final result = ApiResponse<LoginResponse>.fromJson(
        response.data,
        (item) => LoginResponse.fromJson(item as Map<String, dynamic>),
      );

      await TokenManager.setToken(
        result.data!.accessToken,
        result.data!.refreshToken,
      );

      return null;
    } on DioException catch (e) {
      if (e.response != null) {
        try {
          final errorResult = ApiResponse<dynamic>.fromJson(
            e.response!.data,
            (item) => item,
          );

          return errorResult.error ?? errorResult.message;
        } catch (_) {
          return "Terjadi kesalahan pada server (${e.response?.statusCode})";
        }
      }
      return "Koneksi gagal: ${e.message}";
    } catch (e) {
      debugPrint(e.toString());
      return "Koneksi gagal $e";
    }
  }

  Future<bool> logout() async {
    try {
      final response = await ApiClient().dio.post(
        "$kelompok1Url/api/auth/logout",
      );

      debugPrint("Hit api: ${response.data}");

      if (response.statusCode == 200) {
        await TokenManager.clearToken();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<UserResponse> profile() async {
    final response = await ApiClient().dio.get("$kelompok1Url/api/me");
    debugPrint("Hit api: ${response.data}");

    final result = ApiResponse<UserResponse>.fromJson(
      response.data,
      (item) => UserResponse.fromJson(item as Map<String, dynamic>),
    );
    return result.data!;
  }
}
