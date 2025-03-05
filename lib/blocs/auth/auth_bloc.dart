import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_country_apk/model/user_model.dart';
import 'package:get_country_apk/repositories/user_repository.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final UserRepository _userRepository;

  AuthBloc({required UserRepository userRepository})
      : _userRepository = userRepository,
      super(AuthInitial()) {
      on<SignUpRequestedEvent>(_onSignUp);
      on<SignInRequestedEvent>(_onSignIn);
      on<SignOutRequestedEvent>(_onSignOut);
  }

  FutureOr<void> _onSignUp(SignUpRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _userRepository.singUp(
        email: event.email,
        password: event.password,
      );
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthError(message: 'Echec de l\'inscription'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  FutureOr<void> _onSignIn(SignInRequestedEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final user = await _userRepository.singIn(
        email: event.email,
        password: event.password
      );
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(AuthError(message: 'Echec de la connexion'));
      }
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }

  }

  FutureOr<void> _onSignOut(SignOutRequestedEvent event, Emitter<AuthState> emit) async {
    await _userRepository.signOut();
    emit(AuthInitial());
  }
}
