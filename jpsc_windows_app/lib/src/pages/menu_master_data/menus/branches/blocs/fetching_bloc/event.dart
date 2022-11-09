part of 'bloc.dart';

abstract class FetchingBranchesEvent extends Equatable {
  const FetchingBranchesEvent();
  @override
  List<Object?> get props => [];
}

class LoadBranches extends FetchingBranchesEvent {}

class SearchBranchesByKeyword extends FetchingBranchesEvent {
  final String value;

  const SearchBranchesByKeyword(this.value);

  @override
  List<Object?> get props => [value];
}
