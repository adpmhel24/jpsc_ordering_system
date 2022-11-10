part of 'bloc.dart';

abstract class FetchingUoMsEvent extends Equatable {
  const FetchingUoMsEvent();
  @override
  List<Object?> get props => [];
}

class LoadUoms extends FetchingUoMsEvent {}

class SearchUomsByKeyword extends FetchingUoMsEvent {
  final String value;

  const SearchUomsByKeyword(this.value);
  @override
  List<Object?> get props => [value];
}
