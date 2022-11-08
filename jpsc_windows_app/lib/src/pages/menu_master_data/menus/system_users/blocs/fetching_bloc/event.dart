part of 'bloc.dart';

abstract class FetchingSystemUsersEvent extends Equatable {
  const FetchingSystemUsersEvent();

  @override
  List<Object> get props => [];
}

class LoadSystemUsers extends FetchingSystemUsersEvent {}
