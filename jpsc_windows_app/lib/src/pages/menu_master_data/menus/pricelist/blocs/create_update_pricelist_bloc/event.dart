part of 'bloc.dart';

abstract class CreateUpdatePricelistEvent extends Equatable {
  const CreateUpdatePricelistEvent();
  @override
  List<Object?> get props => [];
}

class PricelistCodeChanged extends CreateUpdatePricelistEvent {
  final String code;
  const PricelistCodeChanged(this.code);

  @override
  List<Object?> get props => [code];
}

class PricelistDescChanged extends CreateUpdatePricelistEvent {
  final String description;
  const PricelistDescChanged(this.description);

  @override
  List<Object?> get props => [description];
}

class PricelistIsActiveChanged extends CreateUpdatePricelistEvent {
  final bool isActive;
  const PricelistIsActiveChanged(this.isActive);
  @override
  List<Object?> get props => [isActive];
}

class ButtonSubmitted extends CreateUpdatePricelistEvent {}
