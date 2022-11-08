part of 'bloc.dart';

class UoMBulkUploadState extends Equatable {
  final FormzStatus status;
  final String message;

  const UoMBulkUploadState({
    this.status = FormzStatus.pure,
    this.message = "",
  });

  UoMBulkUploadState copyWith({
    FormzStatus? status,
    String? message,
  }) =>
      UoMBulkUploadState(
          status: status ?? this.status, message: message ?? this.message);

  @override
  List<Object?> get props => [status, message];
}
