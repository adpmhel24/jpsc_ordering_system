part of 'bloc.dart';

abstract class ItemGroupBulkInsertEvent extends Equatable {
  const ItemGroupBulkInsertEvent();
  @override
  List<Object?> get props => [];
}

class UploadButtonSubmitted extends ItemGroupBulkInsertEvent {
  final List<Map<String, dynamic>> value;

  const UploadButtonSubmitted(this.value);
  @override
  List<Object?> get props => [value];
}
