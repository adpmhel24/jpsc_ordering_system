part of 'bloc.dart';

abstract class ProductBulkInsertEvent extends Equatable {
  const ProductBulkInsertEvent();
  @override
  List<Object?> get props => [];
}

class UploadButtonSubmitted extends ProductBulkInsertEvent {
  final List<Map<String, dynamic>> value;

  const UploadButtonSubmitted(this.value);
  @override
  List<Object?> get props => [value];
}
