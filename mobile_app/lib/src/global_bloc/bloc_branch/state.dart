part of 'bloc.dart';

class BranchesBlocState extends Equatable {
  final List<BranchModel> branches;
  final FetchingStatus status;
  final String message;

  const BranchesBlocState({
    this.branches = const [],
    this.status = FetchingStatus.init,
    this.message = "",
  });

  BranchesBlocState copyWith({
    List<BranchModel>? branches,
    FetchingStatus? status,
    String? message,
  }) {
    return BranchesBlocState(
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
