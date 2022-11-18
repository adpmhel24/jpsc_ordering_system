part of 'bloc.dart';

abstract class FetchingCustomersEvents extends Equatable {
  const FetchingCustomersEvents();
  @override
  List<Object?> get props => [];
}

class FetchCustomers extends FetchingCustomersEvents {
  final Map<String, dynamic>? params;

  const FetchCustomers({this.params});
  @override
  List<Object?> get props => [params];
}

class OfflineSearchCustomerByKeyword extends FetchingCustomersEvents {
  final String value;
  const OfflineSearchCustomerByKeyword(this.value);

  @override
  List<Object?> get props => [value];
}
