part of 'bloc.dart';

class FetchingBranchesState extends Equatable {
  final List<BranchModel> branches;
  final FetchingStatus status;
  final String message;

  const FetchingBranchesState({
    this.branches = const [],
    this.status = FetchingStatus.init,
    this.message = "",
  });

  FetchingBranchesState copyWith({
    List<BranchModel>? branches,
    FetchingStatus? status,
    String? message,
  }) {
    return FetchingBranchesState(
      branches: branches ?? this.branches,
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        branches,
        status,
        message,
      ];
}
