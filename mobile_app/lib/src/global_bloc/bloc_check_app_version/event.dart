part of 'bloc.dart';

abstract class CheckAppVersionEvent extends Equatable {
  const CheckAppVersionEvent();

  @override
  List<Object?> get props => [];
}

class CheckingNewVersion extends CheckAppVersionEvent {}
