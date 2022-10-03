part of 'bloc.dart';

class ItemsBlocState extends Equatable {
  final FetchingStatus status;
  final List<ProductModel> datas;
  final String errorMessage;

  const ItemsBlocState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.errorMessage = "",
  });

  ItemsBlocState copyWith({
    FetchingStatus? status,
    List<ProductModel>? datas,
    String? errorMessage,
  }) {
    return ItemsBlocState(
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
