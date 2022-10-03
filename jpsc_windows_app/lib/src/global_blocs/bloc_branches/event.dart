part of 'bloc.dart';

abstract class BranchesBlocEvent extends Equatable {
  const BranchesBlocEvent();
  @override
  List<Object?> get props => [];
}

class BranchesFetchingReq extends BranchesBlocEvent {}

class BranchesPauseFetchingReq extends BranchesBlocEvent {}

class LoadBranches extends BranchesBlocEvent {}
