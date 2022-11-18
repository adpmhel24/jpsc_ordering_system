part of 'bloc.dart';

class FetchingAppVersionsState extends Equatable {
  final FetchingStatus status;
  final List<AppVersionModel> datas;
  final String message;

  const FetchingAppVersionsState({
    this.status = FetchingStatus.init,
    this.datas = const [],
    this.message = "",
  });

  FetchingAppVersionsState copyWith({
    FetchingStatus? status,
    List<AppVersionModel>? datas,
    String? message,
  }) =>
      FetchingAppVersionsState(
        status: status ?? this.status,
        datas: datas ?? this.datas,
        message: message ?? this.message,
      );

  @override
  List<Object?> get props => [status, datas, message];
}
