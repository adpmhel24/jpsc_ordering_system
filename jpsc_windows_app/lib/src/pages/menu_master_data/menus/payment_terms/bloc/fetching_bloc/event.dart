part of 'bloc.dart';

abstract class FetchingPaymentTermsEvent extends Equatable {
  const FetchingPaymentTermsEvent();
  @override
  List<Object?> get props => [];
}

class LoadPaymentTerms extends FetchingPaymentTermsEvent {}
