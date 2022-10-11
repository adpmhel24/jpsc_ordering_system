part of 'itemform_bloc.dart';

abstract class ItemFormEvent extends Equatable {
  const ItemFormEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends ItemFormEvent {
  final TextEditingController name;
  const CodeChanged(this.name);
  @override
  List<Object> get props => [name];
}

class DescriptionChanged extends ItemFormEvent {
  final TextEditingController description;
  const DescriptionChanged(this.description);
  @override
  List<Object> get props => [description];
}

class ItemGroupChanged extends ItemFormEvent {
  final String value;
  const ItemGroupChanged(this.value);
  @override
  List<Object> get props => [value];
}

class SaleUomChanged extends ItemFormEvent {
  final String value;
  const SaleUomChanged(this.value);
  @override
  List<Object> get props => [value];
}

class IsActiveChanged extends ItemFormEvent {
  final bool isActive;
  const IsActiveChanged(this.isActive);
  @override
  List<Object> get props => [isActive];
}

class ButtonSubmitted extends ItemFormEvent {}
