part of 'auth_cubit.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final LoginResponseEntity loginResponseEntity;

  AuthSuccess(this.loginResponseEntity);
}

class AuthError extends AuthState {
  final String errorMessage;
  AuthError(this.errorMessage);
}

class ProfileInitial extends AuthState {}

class ProfileLoading extends AuthState {}

class ProfileSuccess extends AuthState {
  final UserResponseEntity userResponseEntity;

  ProfileSuccess(this.userResponseEntity);
}

class ProfileError extends AuthState {
  final String errorMessage;
  ProfileError(this.errorMessage);
}
