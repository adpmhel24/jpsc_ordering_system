part of 'bloc.dart';

class SystemUserBulkInsertState extends Equatable {
  final FormzStatus status;
  final String message;

  const SystemUserBulkInsertState({
    this.status = FormzStatus.pure,
    this.message = "",
  });

  SystemUserBulkInsertState copyWith({
    FormzStatus? status,
    String? message,
  }) =>
      SystemUserBulkInsertState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
