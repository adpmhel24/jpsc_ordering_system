part of 'bloc.dart';

class ProductsState extends Equatable {
  final FetchingStatus status;
  final List<ProductModel> products;
  final String message;
  const ProductsState({
    this.status = FetchingStatus.init,
    this.products = const [],
    this.message = "",
  });

  ProductsState copyWith({
    FetchingStatus? status,
    List<ProductModel>? products,
    String? message,
  }) {
    return ProductsState(
      status: status ?? this.status,
      products: products ?? this.products,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [
        status,
        products,
        message,
      ];
}
