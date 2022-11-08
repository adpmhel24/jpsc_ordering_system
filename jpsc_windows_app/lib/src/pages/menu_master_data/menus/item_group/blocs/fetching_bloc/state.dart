part of 'bloc.dart';

class FetchingItemGroupState extends Equatable {
  final FetchingStatus status;
  final List<ItemGroupModel> datas;
  final String errorMessage;
  const FetchingItemGroupState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.errorMessage = "",
  });

  FetchingItemGroupState copyWith({
    FetchingStatus? status,
    List<ItemGroupModel>? datas,
    String? errorMessage,
  }) {
    return FetchingItemGroupState(
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
