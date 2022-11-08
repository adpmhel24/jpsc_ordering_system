part of 'bloc.dart';

class ItemGroupBulkInsertState extends Equatable {
  final FormzStatus status;
  final String message;

  const ItemGroupBulkInsertState({
    this.status = FormzStatus.pure,
    this.message = "",
  });

  ItemGroupBulkInsertState copyWith({
    FormzStatus? status,
    String? message,
  }) =>
      ItemGroupBulkInsertState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
