part of 'bloc.dart';

class SalesOrderCancelState extends Equatable {
  final FetchingStatus status;
  final String message;

  const SalesOrderCancelState({
    this.status = FetchingStatus.init,
    this.message = "",
  });

  SalesOrderCancelState copyWith({
    FetchingStatus? status,
    String? message,
  }) =>
      SalesOrderCancelState(
          status: status ?? this.status, message: message ?? this.message);
  @override
  List<Object?> get props => [status, message];
}
