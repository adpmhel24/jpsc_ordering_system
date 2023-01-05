part of 'bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();
  @override
  List<Object?> get props => [];
}

class LoginSubmitted extends AuthEvent {
  final String username;
  final String password;

  const LoginSubmitted({required this.username, required this.password});

  @override
  List<Object> get props => [];
}

class LogoutSubmitted extends AuthEvent {}

class TryToLogin extends AuthEvent {}
