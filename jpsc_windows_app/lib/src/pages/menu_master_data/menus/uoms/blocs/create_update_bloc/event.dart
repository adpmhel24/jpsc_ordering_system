part of 'bloc.dart';

abstract class CreateUpdateUomEvent extends Equatable {
  const CreateUpdateUomEvent();
  @override
  List<Object?> get props => [];
}

class CodeChanged extends CreateUpdateUomEvent {
  final String value;
  const CodeChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class DescriptionChanged extends CreateUpdateUomEvent {
  final String value;
  const DescriptionChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class IsActiveChanged extends CreateUpdateUomEvent {
  final bool value;
  const IsActiveChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class ButtonSubmitted extends CreateUpdateUomEvent {}
