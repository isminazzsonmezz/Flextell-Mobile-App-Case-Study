import 'package:flutter_application_flextell_case/features/auth/data/models/auth_token_model.dart';

abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final AuthTokenModel token;

  AuthAuthenticated(this.token);
}

class AuthError extends AuthState {
  final String message;

  AuthError(this.message);
}