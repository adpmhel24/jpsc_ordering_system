part of 'bloc.dart';

class CreateUpdateAppVersionState extends Equatable {
  final FormzStatus status;
  final FormzString platform;
  final FormzString appName;
  final FormzString packageName;
  final FormzString version;
  final FormzString buildNumber;
  final FormzBool isActive;
  final FormzFile<PlatformFile> file;
  final String message;

  const CreateUpdateAppVersionState({
    this.status = FormzStatus.pure,
    this.platform = const FormzString.pure(),
    this.appName = const FormzString.pure(),
    this.packageName = const FormzString.pure(),
    this.version = const FormzString.pure(),
    this.buildNumber = const FormzString.pure(),
    this.isActive = const FormzBool.dirty(false),
    this.file = const FormzFile.pure(),
    this.message = "",
  });
  CreateUpdateAppVersionState copyWith({
    FormzStatus? status,
    FormzString? platform,
    FormzString? appName,
    FormzString? packageName,
    FormzString? version,
    FormzString? buildNumber,
    FormzBool? isActive,
    FormzFile<PlatformFile>? file,
    String? message,
  }) =>
      CreateUpdateAppVersionState(
          status: status ?? this.status,
          platform: platform ?? this.platform,
          appName: appName ?? this.appName,
          packageName: packageName ?? this.packageName,
          version: version ?? this.version,
          buildNumber: buildNumber ?? this.buildNumber,
          isActive: isActive ?? this.isActive,
          file: file ?? this.file,
          message: message ?? this.message);

  @override
  List<Object?> get props => [
        status,
        platform,
        appName,
        packageName,
        version,
        buildNumber,
        isActive,
        file,
        message,
      ];
}
