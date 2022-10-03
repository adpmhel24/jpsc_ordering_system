part of 'bloc.dart';

class CustomerFetchingEvent extends Equatable {
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
