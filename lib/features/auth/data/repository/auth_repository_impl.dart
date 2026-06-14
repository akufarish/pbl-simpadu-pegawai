import 'package:pegawai_bloc/core/errors/error_handler.dart';
import 'package:pegawai_bloc/core/network/api_response.dart';
import 'package:pegawai_bloc/core/utils/log.dart';
import 'package:pegawai_bloc/core/utils/token_manager.dart';
import 'package:pegawai_bloc/features/auth/data/model/user_model.dart';
import 'package:pegawai_bloc/features/auth/data/remote/auth_remote.dart';
import 'package:pegawai_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:pegawai_bloc/features/auth/domain/repository/auth_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/rendering.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemote authRemote;

  AuthRepositoryImpl(this.authRemote);

  @override
  Future<LoginResponseEntity> login(LoginRequestEntity payload) async {
    try {
      final data = LoginRequest(
        email: payload.email,
        password: payload.password,
      );
      final response = await authRemote.login(data);

      debugApi("login response", response);

      if (response.data != null) {
        await TokenManager.setToken(
          response.data!.accessToken,
          response.data!.refreshToken,
        );

        return response.data!;
      } else {
        throw Exception(response.message);
      }
    } on DioException catch (e) {
      final errorResult = ApiResponse<dynamic>.fromJson(
        e.response!.data,
        (item) => item,
      );

      debugPrint("gagal login: ${errorResult.message}");

      final errorDetail = errorResult.error;

      throw Exception(errorDetail);
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<UserResponseEntity> profile() async {
    try {
      final response = await authRemote.profile();

      if (response.data != null) {
        return response.data!;
      } else {
        throw ErrorHandler.handle(response.message);
      }
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<bool> logout() async {
    try {
      final response = await authRemote.logout();

      if (response.success == true) {
        await TokenManager.clearToken();
        return response.success;
      } else {
        return false;
      }
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }

  @override
  Future<void> register(RegisterRequestEntity payload) async {
    try {
      final response = await authRemote.register(payload.toModel());
      if (response.success == true) {
        return response.data;
      } else {
        throw ErrorHandler.handle(response.message);
      }
    } catch (e) {
      throw ErrorHandler.handle(e);
    }
  }
}
