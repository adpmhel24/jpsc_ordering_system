part of 'bloc.dart';

abstract class CustomerFetchingEvent extends Equatable {
  const CustomerFetchingEvent();
  @override
  List<Object?> get props => [];
}

class FetchCustomers extends CustomerFetchingEvent {
  final Map<String, dynamic>? params;

  const FetchCustomers({this.params});
  @override
  List<Object?> get props => [params];
}

class OfflineSearchCustomerByKeyword extends CustomerFetchingEvent {
  final String value;
  const OfflineSearchCustomerByKeyword(this.value);

  @override
  List<Object?> get props => [value];
}
