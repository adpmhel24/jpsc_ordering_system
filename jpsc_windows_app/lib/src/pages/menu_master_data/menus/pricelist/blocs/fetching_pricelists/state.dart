part of 'bloc.dart';

class PricelistFetchingState extends Equatable {
  final FetchingStatus status;
  final List<PricelistModel> datas;
  final String errorMessage;

  const PricelistFetchingState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.errorMessage = "",
  });

  PricelistFetchingState copyWith({
    FetchingStatus? status,
    List<PricelistModel>? datas,
    String? errorMessage,
  }) {
    return PricelistFetchingState(
      status: status ?? this.status,
      datas: datas ?? this.datas,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        datas,
        errorMessage,
      ];
}
