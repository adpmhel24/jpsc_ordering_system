import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import '../../../../../../utils/string_casing_ext.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_bool.dart';
import '../../../../../../utils/formz_email.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class SystemUserFormBloc
    extends Bloc<SystemUserFormEvent, SystemUserFormState> {
  SystemUserRepo systemUserRepo;
  SystemUserModel? selectedSystemUser;

  SystemUserFormBloc({
    required this.systemUserRepo,
    this.selectedSystemUser,
  }) : super(selectedSystemUser != null
            ? SystemUserFormState(
                firstName: FormzString.dirty(selectedSystemUser.firstName),
                lastName: FormzString.dirty(selectedSystemUser.lastName),
                email: FormzEmail.dirty(selectedSystemUser.email),
                positionCode:
                    FormzString.dirty(selectedSystemUser.positionCode ?? ""),
                isActive: FormzBool.dirty(selectedSystemUser.isActive),
                isSuperAdmin: FormzBool.dirty(selectedSystemUser.isSuperAdmin),
                status: FormzStatus.valid,
              )
            : const SystemUserFormState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PositionCodeChanged>(_onPositionCodeChanged);
    on<IsActiveChanged>(_onIsActiveChanged);
    on<IsSuperAdminChanged>(_onIsSuperAdminChanged);
    on<ButtonSubmitted>(_onButtonSubmitted);
  }

  void _onFirstNameChanged(
      FirstNameChanged event, Emitter<SystemUserFormState> emit) {
    final firstName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        firstName: firstName,
        status: Formz.validate(
          [
            firstName,
            state.lastName,
            state.email,
            if (selectedSystemUser == null) state.password,
            state.positionCode,
          ],
        ),
      ),
    );
  }

  void _onLastNameChanged(
      LastNameChanged event, Emitter<SystemUserFormState> emit) {
    final lastName = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        lastName: lastName,
        status: Formz.validate(
          [
            lastName,
            state.firstName,
            state.email,
            if (selectedSystemUser == null) state.password,
            state.positionCode,
          ],
        ),
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<SystemUserFormState> emit) {
    final email = FormzEmail.dirty(event.value);

    emit(
      state.copyWith(
        email: email,
        status: Formz.validate(
          [
            email,
            state.firstName,
            state.lastName,
            if (selectedSystemUser == null) state.password,
            state.positionCode,
          ],
        ),
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SystemUserFormState> emit) {
    final password = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        password: password,
        status: Formz.validate(
          [
            if (selectedSystemUser == null) password,
            state.firstName,
            state.lastName,
            state.email,
            state.positionCode,
          ],
        ),
      ),
    );
  }

  void _onPositionCodeChanged(
      PositionCodeChanged event, Emitter<SystemUserFormState> emit) {
    final positionCode = FormzString.dirty(event.value);

    emit(
      state.copyWith(
        positionCode: positionCode,
        status: Formz.validate(
          [
            if (selectedSystemUser == null) state.password,
            state.firstName,
            state.lastName,
            state.email,
            positionCode,
          ],
        ),
      ),
    );
  }

  void _onIsActiveChanged(
      IsActiveChanged event, Emitter<SystemUserFormState> emit) {
    final isActive = FormzBool.dirty(event.value);

    emit(
      state.copyWith(
        isActive: isActive,
        status: Formz.validate(
          [
            if (selectedSystemUser == null) state.password,
            state.firstName,
            state.lastName,
            state.email,
            state.positionCode,
          ],
        ),
      ),
    );
  }

  void _onIsSuperAdminChanged(
      IsSuperAdminChanged event, Emitter<SystemUserFormState> emit) {
    final isSuperAdmin = FormzBool.dirty(event.value);

    emit(
      state.copyWith(
        isSuperAdmin: isSuperAdmin,
        status: Formz.validate(
          [
            if (selectedSystemUser == null) state.password,
            state.firstName,
            state.lastName,
            state.email,
            state.positionCode,
          ],
        ),
      ),
    );
  }

  void _onButtonSubmitted(
      ButtonSubmitted event, Emitter<SystemUserFormState> emit) async {
    Map<String, dynamic> data = {
      "email": state.email.value.toLowerCase(),
      "first_name": state.firstName.value.toTitleCase(),
      "last_name": state.lastName.value.toTitleCase(),
      "is_active": state.isActive.value,
      "is_super_admin": state.isSuperAdmin.value,
      "position_code":
          state.positionCode.value.isEmpty ? null : state.positionCode.value,
      "password": state.password.value.isEmpty ? null : state.password.value,
    };
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      String message;
      if (selectedSystemUser != null) {
        message =
            await systemUserRepo.update(id: selectedSystemUser!.id, data: data);
      } else {
        message = await systemUserRepo.create(data);
      }
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: message,
        ),
      );
    } on HttpException catch (err) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          message: err.message,
        ),
      );
    }
  }
}
