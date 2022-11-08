part of 'bloc.dart';

abstract class CreateUpdateProductEvent extends Equatable {
  const CreateUpdateProductEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends CreateUpdateProductEvent {
  final TextEditingController name;
  const CodeChanged(this.name);
  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends CreateUpdateProductEvent {
  final TextEditingController description;
  const DescriptionChanged(this.description);
  @override
  List<Object> get props => [description];
}

class ItemGroupChanged extends CreateUpdateProductEvent {
  final String value;
  const ItemGroupChanged(this.value);
  @override
  List<Object> get props => [value];
}

class SaleUomChanged extends CreateUpdateProductEvent {
  final String value;
  const SaleUomChanged(this.value);
  @override
  List<Object> get props => [value];
}

class IsActiveChanged extends CreateUpdateProductEvent {
  final bool isActive;
  const IsActiveChanged(this.isActive);
  @override
  List<Object> get props => [isActive];
}

class ButtonSubmitted extends CreateUpdateProductEvent {}
