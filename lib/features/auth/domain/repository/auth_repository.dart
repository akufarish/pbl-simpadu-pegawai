import 'package:pegawai_bloc/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<LoginResponseEntity> login(LoginRequestEntity payload);

  Future<UserResponseEntity> profile();

  Future<bool> logout();

  Future<void> register(RegisterRequestEntity payload);
}
