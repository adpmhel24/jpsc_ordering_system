part of 'bloc.dart';

abstract class UoMBulkUploadEvent extends Equatable {
  const UoMBulkUploadEvent();
  @override
  List<Object?> get props => [];
}

class UploadButtonSubmitted extends UoMBulkUploadEvent {
  final List<Map<String, dynamic>> value;

  const UploadButtonSubmitted(this.value);
  @override
  List<Object?> get props => [value];
}
