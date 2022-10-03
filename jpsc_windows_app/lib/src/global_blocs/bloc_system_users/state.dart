part of 'bloc.dart';

class SystemUsersBlocState extends Equatable {
  final FetchingStatus status;
  final List<SystemUserModel> systemUsers;
  final String message;

  const SystemUsersBlocState({
    this.status = FetchingStatus.init,
    this.systemUsers = const [],
    this.message = '',
  });

  SystemUsersBlocState copyWith({
    FetchingStatus? status,
    List<SystemUserModel>? systemUsers,
    String? message,
  }) {
    return SystemUsersBlocState(
      status: status ?? this.status,
      systemUsers: systemUsers ?? this.systemUsers,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, systemUsers, message];
}
