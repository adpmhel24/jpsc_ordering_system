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
  final TextEditingController itemGrp;
  const ItemGroupChanged(this.itemGrp);
  @override
  List<Object> get props => [itemGrp];
}

class SaleUomChanged extends ItemFormEvent {
  final TextEditingController saleUom;
  const SaleUomChanged(this.saleUom);
  @override
  List<Object> get props => [saleUom];
}

class IsActiveChanged extends ItemFormEvent {
  final bool isActive;
  const IsActiveChanged(this.isActive);
  @override
  List<Object> get props => [isActive];
}

class CreateButtonSubmitted extends ItemFormEvent {}

class UpdateButtonSubmitted extends ItemFormEvent {}
