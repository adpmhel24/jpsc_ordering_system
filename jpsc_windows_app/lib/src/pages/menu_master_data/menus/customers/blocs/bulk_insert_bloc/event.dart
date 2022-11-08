part of 'bloc.dart';

abstract class CustomerBulkInsertEvent extends Equatable {
  const CustomerBulkInsertEvent();
  @override
  List<Object?> get props => [];
}

class UploadButtonSubmitted extends CustomerBulkInsertEvent {
  final List<Map<String, dynamic>> value;

  const UploadButtonSubmitted(this.value);
  @override
  List<Object?> get props => [value];
}
