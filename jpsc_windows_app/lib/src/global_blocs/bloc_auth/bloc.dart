import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/repositories/repos.dart';

part 'event.dart';
part 'state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final CurrentUserRepo _currUserRepo;

  AuthBloc(this._currUserRepo) : super(const AuthState()) {
    on<LoginSubmitted>(_onLoginSubmitted);
    on<LogoutSubmitted>(_onLogoutSubmitted);
    on<TryToLogin>(_onTryToLogin);
  }
  void _onLoginSubmitted(LoginSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _currUserRepo.loginWithCredentials(
          {"username": event.username, "password": event.password});
      emit(state.copyWith(status: AuthStateStatus.loggedIn));
    } on HttpException catch (err) {
      emit(
        state.copyWith(status: AuthStateStatus.error, message: err.message),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStateStatus.error, message: e.toString()),
      );
    }
  }

  void _onTryToLogin(TryToLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    try {
      await _currUserRepo.checkIfLoggedIn();

      if (_currUserRepo.loginStatus == LoginStatus.loggedin) {
        emit(state.copyWith(status: AuthStateStatus.loggedIn));
      } else if (_currUserRepo.loginStatus == LoginStatus.loggedout) {
        emit(state.copyWith(status: AuthStateStatus.loggedOut));
      }
    } on HttpException catch (e) {
      emit(
        state.copyWith(status: AuthStateStatus.error, message: e.message),
      );
    } catch (e) {
      emit(
        state.copyWith(status: AuthStateStatus.error, message: e.toString()),
      );
    }
  }

  void _onLogoutSubmitted(
      LogoutSubmitted event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: AuthStateStatus.loading));
    await _currUserRepo.logout();
    emit(state.copyWith(status: AuthStateStatus.loggedOut));
  }
}
