part of 'bloc.dart';

abstract class PricelistRowsUpdateEvent extends Equatable {
  const PricelistRowsUpdateEvent();
  @override
  List<Object?> get props => [];
}

class UpdateSubmitted extends PricelistRowsUpdateEvent {
  final List<Map<String, dynamic>> items;

  const UpdateSubmitted({
    required this.items,
  });

  @override
  List<Object?> get props => [items];
}
