part of 'bloc.dart';

abstract class CreateUpdatePaymentTermEvent extends Equatable {
  const CreateUpdatePaymentTermEvent();
  @override
  List<Object?> get props => [];
}

class PayTermCodeChanged extends CreateUpdatePaymentTermEvent {
  final String value;

  const PayTermCodeChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class PayTermDescriptionChanged extends CreateUpdatePaymentTermEvent {
  final String value;

  const PayTermDescriptionChanged(this.value);

  @override
  List<Object?> get props => [value];
}

class CreateUpadteSubmitted extends CreateUpdatePaymentTermEvent {}
