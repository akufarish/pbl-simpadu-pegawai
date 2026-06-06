import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart';

@JsonSerializable()
class LoginRequest {
  final String email;
  final String password;

  LoginRequest({required this.email, required this.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);
  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class RegisterRequest {
  final String name;
  final String email;
  final String password;
  @JsonKey(name: "role_name")
  final String roleName;
  @JsonKey(name: "detail_id")
  final String detailId;

  RegisterRequest({
    required this.name,
    required this.email,
    required this.password,
    required this.roleName,
    required this.detailId,
  });

  factory RegisterRequest.fromJson(Map<String, dynamic> json) =>
      _$RegisterRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RegisterRequestToJson(this);
}

@JsonSerializable()
class LoginResponse {
  @JsonKey(name: "access_token")
  final String accessToken;
  @JsonKey(name: "refresh_token")
  final String refreshToken;
  @JsonKey(name: "role_name")
  final String roleName;

  LoginResponse({
    required this.accessToken,
    required this.refreshToken,
    required this.roleName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserResponse {
  final String id;
  final String name;
  final String email;
  @JsonKey(name: "role_name")
  final String roleName;
  @JsonKey(name: "detail_id")
  final String? detailId;
  @JsonKey(name: "image_url")
  final String? imageUrl;

  UserResponse({
    required this.id,
    required this.name,
    required this.email,
    required this.roleName,
    required this.detailId,
    required this.imageUrl,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);
  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
}

@JsonSerializable()
class RefreshTokenRequest {
  @JsonKey(name: "refresh_token")
  final String refreshToken;

  RefreshTokenRequest({required this.refreshToken});

  factory RefreshTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestFromJson(json);
  Map<String, dynamic> toJson() => _$RefreshTokenRequestToJson(this);
}
