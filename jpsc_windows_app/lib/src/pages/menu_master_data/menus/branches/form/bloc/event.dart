part of 'bloc.dart';

abstract class BranchFormEvent extends Equatable {
  const BranchFormEvent();
  @override
  List<Object?> get props => [];
}

class BranchCodeChanged extends BranchFormEvent {
  final TextEditingController nameController;

  const BranchCodeChanged(this.nameController);

  @override
  List<Object> get props => [nameController];
}

class BranchDescriptionChanged extends BranchFormEvent {
  final TextEditingController descriptionController;

  const BranchDescriptionChanged(this.descriptionController);

  @override
  List<Object> get props => [descriptionController];
}

class BranchPricelistChanged extends BranchFormEvent {
  final TextEditingController pricelistCodeController;

  const BranchPricelistChanged(this.pricelistCodeController);

  @override
  List<Object> get props => [pricelistCodeController];
}

class BranchIsActiveChanged extends BranchFormEvent {
  final bool isActive;

  const BranchIsActiveChanged(this.isActive);
  @override
  List<Object?> get props => [isActive];
}

class CreateButtonSubmitted extends BranchFormEvent {}

class UpdateButtonSubmitted extends BranchFormEvent {}
