import 'package:pegawai_bloc/features/auth/domain/entities/user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'user_model.g.dart';

@JsonSerializable()
class LoginRequest extends LoginRequestEntity {
  LoginRequest({required super.email, required super.password});

  factory LoginRequest.fromJson(Map<String, dynamic> json) =>
      _$LoginRequestFromJson(json);

  Map<String, dynamic> toJson() => _$LoginRequestToJson(this);
}

@JsonSerializable()
class LoginResponse extends LoginResponseEntity {
  LoginResponse({
    @JsonKey(name: "access_token") required super.accessToken,
    @JsonKey(name: "refresh_token") required super.refreshToken,
    @JsonKey(name: "role_name") required super.roleName,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) =>
      _$LoginResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResponseToJson(this);
}

@JsonSerializable()
class UserResponse extends UserResponseEntity {
  UserResponse({
    required super.id,
    required super.name,
    required super.email,
    @JsonKey(name: "role_name") required super.roleName,
    @JsonKey(name: "detail_id") super.detailId,
    @JsonKey(name: "image_url") super.imageUrl,
  });

  factory UserResponse.fromJson(Map<String, dynamic> json) =>
      _$UserResponseFromJson(json);

  Map<String, dynamic> toJson() => _$UserResponseToJson(this);
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
