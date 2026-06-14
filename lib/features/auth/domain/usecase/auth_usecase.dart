import 'package:pegawai_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:pegawai_bloc/features/auth/domain/repository/auth_repository.dart';

class AuthUsecase {
  final AuthRepository authRepository;

  AuthUsecase({required this.authRepository});

  Future<LoginResponseEntity> doLogin(LoginRequestEntity payload) async {
    return await authRepository.login(payload);
  }

  Future<UserResponseEntity> profile() async {
    return await authRepository.profile();
  }

  Future<bool> logout() async {
    return await authRepository.logout();
  }

  Future<void> register(RegisterRequestEntity payload) async {
    return await authRepository.register(payload);
  }
}
