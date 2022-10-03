part of 'bloc.dart';

abstract class SystemUsersBlocEvent extends Equatable {
  const SystemUsersBlocEvent();

  @override
  List<Object> get props => [];
}

class LoadSystemUsers extends SystemUsersBlocEvent {}
