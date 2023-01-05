part of 'bloc.dart';

class CheckAppVersionState extends Equatable {
  final AppVersionStatus status;
  final AppVersionModel? data;
  final String message;

  const CheckAppVersionState({
    this.status = AppVersionStatus.init,
    this.data,
    this.message = "",
  });

  CheckAppVersionState copyWith({
    AppVersionStatus? status,
    AppVersionModel? data,
    String? message,
  }) =>
      CheckAppVersionState(
          status: status ?? this.status,
          data: data ?? this.data,
          message: message ?? this.message);

  @override
  List<Object?> get props => [
        status,
        message,
        data,
      ];
}
