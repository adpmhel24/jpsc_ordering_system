part of 'bloc.dart';

abstract class SystemUserBulkInsertEvent extends Equatable {
  const SystemUserBulkInsertEvent();
  @override
  List<Object?> get props => [];
}

class UploadButtonSubmitted extends SystemUserBulkInsertEvent {
  final List<Map<String, dynamic>> value;

  const UploadButtonSubmitted(this.value);
  @override
  List<Object?> get props => [value];
}
