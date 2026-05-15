import 'package:flutter_application_flextell_case/features/auth/bloc/Auth_Bloc/auth_event.dart';
import 'package:flutter_application_flextell_case/features/auth/bloc/Auth_Bloc/auth_state.dart';
import 'package:flutter_application_flextell_case/features/auth/data/repositories/auth_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository repository;

  AuthBloc(this.repository) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final token = await repository.login();

      emit(AuthAuthenticated(token));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}