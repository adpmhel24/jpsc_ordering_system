part of 'bloc.dart';

enum AuthStateStatus { init, loading, loggedIn, loggedOut, error }

class AuthState extends Equatable {
  final AuthStateStatus status;
  final String message;

  const AuthState({this.status = AuthStateStatus.init, this.message = ""});

  AuthState copyWith({AuthStateStatus? status, String? message}) {
    return AuthState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
