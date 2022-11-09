part of 'bloc.dart';

abstract class FetchingSystemUsersEvent extends Equatable {
  const FetchingSystemUsersEvent();

  @override
  List<Object> get props => [];
}

class SearchSystemUserByKeyword extends FetchingSystemUsersEvent {
  final String value;
  const SearchSystemUserByKeyword(this.value);
  @override
  List<Object> get props => [value];
}

class LoadSystemUsers extends FetchingSystemUsersEvent {}
