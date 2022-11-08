part of 'bloc.dart';

abstract class UomFormBlocEvent extends Equatable {
  const UomFormBlocEvent();
  @override
  List<Object?> get props => [];
}

class CodeChanged extends UomFormBlocEvent {
  final TextEditingController codeController;
  const CodeChanged(this.codeController);
  @override
  List<Object?> get props => [codeController];
}

class DescriptionChanged extends UomFormBlocEvent {
  final TextEditingController descriptionController;
  const DescriptionChanged(this.descriptionController);
  @override
  List<Object?> get props => [descriptionController];
}

class IsActiveChanged extends UomFormBlocEvent {
  final bool? isActive;
  const IsActiveChanged(this.isActive);
  @override
  List<Object?> get props => [isActive];
}

class CreateButtonSubmitted extends UomFormBlocEvent {}

class UpdateButtonSubmitted extends UomFormBlocEvent {}
