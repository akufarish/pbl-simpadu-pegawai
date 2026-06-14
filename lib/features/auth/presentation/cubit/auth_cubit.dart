import 'package:pegawai_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:pegawai_bloc/features/auth/domain/usecase/auth_usecase.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthUsecase authUsecase;

  AuthCubit(this.authUsecase) : super(AuthInitial());

  Future<bool> login(LoginRequestEntity payload) async {
    emit(AuthLoading());
    try {
      final result = await authUsecase.doLogin(payload);
      emit(AuthSuccess(result));
      return true;
    } catch (e) {
      emit(AuthError(e.toString().replaceAll('Exception: ', '')));
      return false;
    }
  }

  Future<void> profile() async {
    emit(ProfileLoading());
    try {
      final result = await authUsecase.profile();
      emit(ProfileSuccess(result));
    } catch (e) {
      emit(ProfileError(e.toString().replaceAll("Exception:", "")));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      final result = await authUsecase.logout();

      if (result) {
        emit(AuthInitial());
      } else {
        emit(AuthError("samting wong"));
      }
    } catch (e) {
      emit(AuthError(e.toString().replaceAll("Exception:", "")));
    }
  }
}
