import 'dart:io';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http_parser/http_parser.dart';
import 'package:jpsc_windows_app/src/utils/formz_bool.dart';

import '../../../../../../data/repositories/repo_app_version.dart';
import '../../../../../../utils/formz_string.dart';
import '../../../../../../utils/formz_validator.dart';

part 'events.dart';
part 'state.dart';

class CreateUpdateAppVersionBloc
    extends Bloc<CreateUpdateAppVersionEvent, CreateUpdateAppVersionState> {
  final AppVersionRepo repo;
  CreateUpdateAppVersionBloc(this.repo)
      : super(const CreateUpdateAppVersionState()) {
    on<PlatformChanged>(_onPlatformChanged);
    on<AppNameChanged>(_onAppNameChanged);
    on<PackageNameChanged>(_onPackageNameChanged);
    on<BuildNumberChanged>(_onBuildNumberChanged);
    on<IsActiveChanged>(_onIsActiveChanged);
    on<VersionChanged>(_onVersionChanged);
    on<FileAdded>(_onFileAdded);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onPlatformChanged(
      PlatformChanged event, Emitter<CreateUpdateAppVersionState> emit) {
    final platform = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        platform: platform,
        status: Formz.validate(
          [
            platform,
            state.appName,
            state.packageName,
            state.buildNumber,
            state.isActive,
            state.version,
            state.file,
          ],
        ),
      ),
    );
  }

  void _onAppNameChanged(
      AppNameChanged event, Emitter<CreateUpdateAppVersionState> emit) {
    final appName = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        appName: appName,
        status: Formz.validate(
          [
            state.platform,
            appName,
            state.packageName,
            state.buildNumber,
            state.isActive,
            state.version,
            state.file,
          ],
        ),
      ),
    );
  }

  void _onPackageNameChanged(
      PackageNameChanged event, Emitter<CreateUpdateAppVersionState> emit) {
    final packageName = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        packageName: packageName,
        status: Formz.validate(
          [
            state.platform,
            state.appName,
            packageName,
            state.buildNumber,
            state.isActive,
            state.version,
            state.file,
          ],
        ),
      ),
    );
  }

  void _onBuildNumberChanged(
      BuildNumberChanged event, Emitter<CreateUpdateAppVersionState> emit) {
    final buildNumber = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        buildNumber: buildNumber,
        status: Formz.validate(
          [
            state.platform,
            state.appName,
            state.packageName,
            buildNumber,
            state.isActive,
            state.version,
            state.file,
          ],
        ),
      ),
    );
  }

  void _onIsActiveChanged(
      IsActiveChanged event, Emitter<CreateUpdateAppVersionState> emit) {
    final isActive = FormzBool.dirty(event.value);
    emit(
      state.copyWith(
        isActive: isActive,
        status: Formz.validate(
          [
            state.platform,
            state.appName,
            state.packageName,
            state.buildNumber,
            isActive,
            state.version,
            state.file,
          ],
        ),
      ),
    );
  }

  void _onVersionChanged(
      VersionChanged event, Emitter<CreateUpdateAppVersionState> emit) {
    final version = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        version: version,
        status: Formz.validate(
          [
            state.platform,
            state.appName,
            state.packageName,
            state.buildNumber,
            state.isActive,
            version,
            state.file,
          ],
        ),
      ),
    );
  }

  void _onFileAdded(
      FileAdded event, Emitter<CreateUpdateAppVersionState> emit) {
    final file = FormzFile.dirty(event.value);
    emit(
      state.copyWith(
        file: file,
        status: Formz.validate(
          [
            state.platform,
            state.appName,
            state.packageName,
            state.buildNumber,
            state.isActive,
            state.version,
            file,
          ],
        ),
      ),
    );
  }

  void _onButtonSubmitted(
      ButtonSubmitted event, Emitter<CreateUpdateAppVersionState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    try {
      Map<String, dynamic> data = {
        "platform": state.platform.value,
        "app_name": state.appName.value,
        "package_name": state.packageName.value,
        "version": state.version.value,
        "build_number": state.buildNumber.value,
        "is_active": state.isActive.value,
        "file": MultipartFile.fromBytes(
          state.file.value?.bytes ?? [],
          filename: state.file.value?.name ?? "",
          contentType:
              MediaType("application/vnd.android.package-archive", "apk"),
        )
      };

      String message = await repo.create(data);
      emit(state.copyWith(
          status: FormzStatus.submissionSuccess, message: message));
    } on HttpException catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.message));
    } on Exception catch (e) {
      emit(state.copyWith(
          status: FormzStatus.submissionFailure, message: e.toString()));
    }
  }
}
