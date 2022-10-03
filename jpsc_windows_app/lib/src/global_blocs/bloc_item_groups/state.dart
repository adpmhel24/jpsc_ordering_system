part of 'bloc.dart';

class ItemGroupsBlocState extends Equatable {
  final FetchingStatus status;
  final List<ItemGroupModel> itemGroups;
  final String? errorMessage;
  const ItemGroupsBlocState({
    this.status = FetchingStatus.init,
    this.itemGroups = const [],
    this.errorMessage = "",
  });

  ItemGroupsBlocState copyWith({
    FetchingStatus? status,
    List<ItemGroupModel>? itemGroups,
    String? errorMessage,
  }) {
    return ItemGroupsBlocState(
      status: status ?? this.status,
      itemGroups: itemGroups ?? this.itemGroups,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        itemGroups,
        errorMessage,
      ];
}
