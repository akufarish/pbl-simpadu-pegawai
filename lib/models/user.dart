import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) {
    return LoginRequest(email: json["email"], password: json["password"]);
  }

  Map<String, dynamic> toJson() => {'email': email, 'password': password};
}

@JsonSerializable()
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  final String roleName;
  final String detailId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.roleName,
    required this.detailId,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) {
    return RegisterRequest(
      name: json["name"],
      email: json["email"],
      password: json["password"],
      roleName: json["role_name"],
      detailId: json["detail_id"],
    );
  }

  Map<String, dynamic> toJson() => {
    "name": name,
    "email": email,
    "password": password,
    "role_name": roleName,
    "detail_id": detailId,
  };
}

@JsonSerializable()
class LoginResponse {
  final String accessToken;
  final String refreshToken;
  final String roleName;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.roleName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      roleName: json["role_name"],
    );
  }
}

@JsonSerializable()
class UserResponse {
  final String id;
  final String name;
  final String email;
  final String roleName;
  final String? detailId;
  final String? imageUrl;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    required this.detailId,
    required this.imageUrl,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      id: json["id"],
      name: json["name"],
      email: json["email"],
      roleName: json["role_name"],
      detailId: json["detail_id"],
      imageUrl: json["image_url"],
    );
  }
}
