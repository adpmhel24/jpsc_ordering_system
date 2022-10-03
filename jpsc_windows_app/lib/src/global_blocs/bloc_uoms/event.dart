part of 'bloc.dart';

abstract class UomsBlocEvent extends Equatable {
  const UomsBlocEvent();
  @override
  List<Object?> get props => [];
}

class LoadUoms extends UomsBlocEvent {}
