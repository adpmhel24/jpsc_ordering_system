part of 'bloc.dart';

class FetchingUoMsState extends Equatable {
  final FetchingStatus status;
  final List<UomModel> uoms;
  final String errorMessage;

  const FetchingUoMsState({
    this.status = FetchingStatus.init,
    this.uoms = const [],
    this.errorMessage = "",
  });

  FetchingUoMsState copyWith({
    FetchingStatus? status,
    List<UomModel>? uoms,
    String? errorMessage,
  }) {
    return FetchingUoMsState(
      status: status ?? this.status,
      uoms: uoms ?? this.uoms,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        uoms,
        errorMessage,
      ];
}
