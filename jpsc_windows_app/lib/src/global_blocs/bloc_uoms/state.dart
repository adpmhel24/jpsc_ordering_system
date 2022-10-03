part of 'bloc.dart';

class UomsBlocState extends Equatable {
  final FetchingStatus status;
  final List<UomModel> uoms;
  final String errorMessage;

  const UomsBlocState({
    this.status = FetchingStatus.init,
    this.uoms = const [],
    this.errorMessage = "",
  });

  UomsBlocState copyWith({
    FetchingStatus? status,
    List<UomModel>? uoms,
    String? errorMessage,
  }) {
    return UomsBlocState(
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
