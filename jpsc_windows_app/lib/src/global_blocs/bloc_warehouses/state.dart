part of 'bloc.dart';

class WarehousesBlocState extends Equatable {
  final List<WarehouseModel> warehouses;
  final FetchingStatus status;
  final String errorMessage;

  const WarehousesBlocState({
    this.warehouses = const [],
    this.status = FetchingStatus.init,
    this.errorMessage = "",
  });

  WarehousesBlocState copyWith({
    List<WarehouseModel>? warehouses,
    FetchingStatus? status,
    String? errorMessage,
  }) {
    return WarehousesBlocState(
      warehouses: warehouses ?? this.warehouses,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        warehouses,
        status,
        errorMessage,
      ];
}
