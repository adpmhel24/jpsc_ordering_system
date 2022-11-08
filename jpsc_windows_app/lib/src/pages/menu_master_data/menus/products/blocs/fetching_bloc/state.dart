part of 'bloc.dart';

class FetchingProductsState extends Equatable {
  final FetchingStatus status;
  final List<ProductModel> datas;
  final String errorMessage;

  const FetchingProductsState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.errorMessage = "",
  });

  FetchingProductsState copyWith({
    FetchingStatus? status,
    List<ProductModel>? datas,
    String? errorMessage,
  }) {
    return FetchingProductsState(
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
