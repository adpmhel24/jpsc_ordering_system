part of 'bloc.dart';

abstract class CreateUpdateBranchEvent extends Equatable {
  const CreateUpdateBranchEvent();
  @override
  List<Object?> get props => [];
}

class BranchCodeChanged extends CreateUpdateBranchEvent {
  final String value;

  const BranchCodeChanged(this.value);

  @override
  List<Object> get props => [value];
}

class BranchDescriptionChanged extends CreateUpdateBranchEvent {
  final String value;

  const BranchDescriptionChanged(this.value);

  @override
  List<Object> get props => [value];
}

class BranchPricelistChanged extends CreateUpdateBranchEvent {
  final String value;

  const BranchPricelistChanged(this.value);

  @override
  List<Object> get props => [value];
}

class BranchIsActiveChanged extends CreateUpdateBranchEvent {
  final bool value;

  const BranchIsActiveChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class ButtonSubmitted extends CreateUpdateBranchEvent {}
