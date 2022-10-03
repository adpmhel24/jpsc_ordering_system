import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo = AuthRepo();
  AuthBloc() : super(const AuthState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutSubmitted>(_onLogoutSubmitted);
  }

  void _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    try {
      emit(state.copyWith(status: AuthStateStatus.loading));

      await _authRepo.loginWithCredentials(
          {"username": event.username, "password": event.password});
      emit(state.copyWith(status: AuthStateStatus.loggedIn));
    } on HttpException catch (err) {
      emit(
        state.copyWith(status: AuthStateStatus.error, message: err.message),
      );
    }
  }

  void _onLogoutSubmitted(
      LogoutSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    await _authRepo.logout();
    emit(state.copyWith(status: AuthStateStatus.loggedOut));
  }
}
