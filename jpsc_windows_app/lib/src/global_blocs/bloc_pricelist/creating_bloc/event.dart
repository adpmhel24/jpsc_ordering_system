part of 'bloc.dart';

abstract class PricelistCreateEvent extends Equatable {
  const PricelistCreateEvent();
  @override
  List<Object?> get props => [];
}

class PricelistCodeChanged extends PricelistCreateEvent {
  final String code;
  const PricelistCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class PricelistDescChanged extends PricelistCreateEvent {
  final String description;
  const PricelistDescChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class PricelistIsActiveChanged extends PricelistCreateEvent {
  final bool isActive;
  const PricelistIsActiveChanged(this.isActive);
  @override
  List<Object?> get props => [isActive];
}

class PriceListCreateSubmitted extends PricelistCreateEvent {}
