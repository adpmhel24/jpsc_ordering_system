part of 'bloc.dart';

class CustomerFetchingState extends Equatable {
  final FetchingStatus status;
  final List<CustomerModel> datas;
  final String message;

  const CustomerFetchingState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  CustomerFetchingState copyWith({
    FetchingStatus? status,
    List<CustomerModel>? datas,
    String? message,
  }) =>
      CustomerFetchingState(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, datas, message];
}
