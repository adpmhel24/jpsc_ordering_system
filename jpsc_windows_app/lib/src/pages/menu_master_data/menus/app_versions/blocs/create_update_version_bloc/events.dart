part of 'bloc.dart';

abstract class CreateUpdateAppVersionEvent extends Equatable {
  const CreateUpdateAppVersionEvent();
  @override
  List<Object?> get props => [];
}

class PlatformChanged extends CreateUpdateAppVersionEvent {
  final String value;
  const PlatformChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class AppNameChanged extends CreateUpdateAppVersionEvent {
  final String value;
  const AppNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PackageNameChanged extends CreateUpdateAppVersionEvent {
  final String value;
  const PackageNameChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class VersionChanged extends CreateUpdateAppVersionEvent {
  final String value;
  const VersionChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class BuildNumberChanged extends CreateUpdateAppVersionEvent {
  final String value;
  const BuildNumberChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class FileAdded extends CreateUpdateAppVersionEvent {
  final PlatformFile? value;
  const FileAdded(this.value);

  @override
  List<Object?> get props => [value];
}

class IsActiveChanged extends CreateUpdateAppVersionEvent {
  final bool value;
  const IsActiveChanged(this.value);
  @override
  List<Object?> get props => [value];
}

class ButtonSubmitted extends CreateUpdateAppVersionEvent {}
