part of 'bloc.dart';

class FetchingSystemUsersState extends Equatable {
  final FetchingStatus status;
  final List<SystemUserModel> systemUsers;
  final String message;

  const FetchingSystemUsersState({
    this.status = FetchingStatus.init,
    this.systemUsers = const [],
    this.message = '',
  });

  FetchingSystemUsersState copyWith({
    FetchingStatus? status,
    List<SystemUserModel>? systemUsers,
    String? message,
  }) {
    return FetchingSystemUsersState(
      status: status ?? this.status,
      systemUsers: systemUsers ?? this.systemUsers,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, systemUsers, message];
}
