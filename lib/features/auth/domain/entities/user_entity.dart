import 'package:pegawai_bloc/features/auth/data/model/user_model.dart';

class LoginRequestEntity {
  final String email;
  final String password;

  const LoginRequestEntity({required this.email, required this.password});
}

class LoginResponseEntity {
  final String accessToken;
  final String refreshToken;
  final String roleName;

  const LoginResponseEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.roleName,
  });
}

class UserResponseEntity {
  final String id;
  final String name;
  final String email;
  final String roleName;
  final String? detailId;
  final String? imageUrl;

  UserResponseEntity({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    this.detailId,
    this.imageUrl,
  });
}

class RegisterRequestEntity {
  final String name;
  final String email;
  final String password;
  final String roleName;
  final String detailId;

  RegisterRequestEntity({
    required this.name,
    required this.email,
    required this.password,
    required this.roleName,
    required this.detailId,
  });

  RegisterRequest toModel() {
    return RegisterRequest(
      name: name,
      email: email,
      password: password,
      roleName: roleName,
      detailId: detailId,
    );
  }
}
