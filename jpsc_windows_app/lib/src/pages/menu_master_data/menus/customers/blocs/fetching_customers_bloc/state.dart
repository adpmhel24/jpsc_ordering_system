part of 'bloc.dart';

class FetchingCustomersStates extends Equatable {
  final FetchingStatus status;
  final List<CustomerModel> datas;
  final String message;

  const FetchingCustomersStates({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  FetchingCustomersStates copyWith({
    FetchingStatus? status,
    List<CustomerModel>? datas,
    String? message,
  }) =>
      FetchingCustomersStates(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, datas, message];
}
