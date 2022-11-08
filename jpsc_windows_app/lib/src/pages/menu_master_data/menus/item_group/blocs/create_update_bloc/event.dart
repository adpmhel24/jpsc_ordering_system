part of 'bloc.dart';

abstract class CreateUpdateItemGroupEvent extends Equatable {
  const CreateUpdateItemGroupEvent();
  @override
  List<Object?> get props => [];
}

class CodeChanged extends CreateUpdateItemGroupEvent {
  final TextEditingController codeController;
  const CodeChanged(this.codeController);
  @override
  List<Object?> get props => [codeController];
}

class DescriptionChanged extends CreateUpdateItemGroupEvent {
  final TextEditingController descriptionController;
  const DescriptionChanged(this.descriptionController);
  @override
  List<Object?> get props => [descriptionController];
}

class IsActiveChanged extends CreateUpdateItemGroupEvent {
  final bool? isActive;
  const IsActiveChanged(this.isActive);
  @override
  List<Object?> get props => [isActive];
}

class ButtonSubmitted extends CreateUpdateItemGroupEvent {}
