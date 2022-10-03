import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:flutter/material.dart';
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
  }) : super(const SystemUserFormState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<PositionCodeChanged>(_onPositionCodeChanged);
    on<CreateButtonSubmitted>(_onCreateButtonSubmitted);
    on<UpdateButtonSubmitted>(_onUpdateButtonSubmitted);
  }

  void _onFirstNameChanged(
      FirstNameChanged event, Emitter<SystemUserFormState> emit) {
    FormzString firstName;
    FormzStatus status;
    // Check if the selected system user is not null for updating
    if (selectedSystemUser != null) {
      if (selectedSystemUser?.firstName == event.firstNameController.text) {
        firstName = const FormzString.pure();
      } else {
        firstName = FormzString.dirty(event.firstNameController.text);
      }
      status = Formz.validate(
        [
          if (!firstName.pure) firstName,
          if (!state.lastName.pure) state.lastName,
          if (!state.email.pure) state.email,
          if (!state.password.pure) state.password,
          if (!state.positionCode.pure) state.positionCode,
        ],
      );
    } else {
      // this bloc is for new system user.
      firstName = FormzString.dirty(event.firstNameController.text);
      status = Formz.validate(
        [
          firstName,
          state.lastName,
          state.email,
          state.password,
          state.positionCode,
        ],
      );
    }

    emit(
      state.copyWith(
        firstName: firstName,
        status: status,
      ),
    );
  }

  void _onLastNameChanged(
      LastNameChanged event, Emitter<SystemUserFormState> emit) {
    FormzString lastName;
    FormzStatus status;

    if (selectedSystemUser != null) {
      if (selectedSystemUser!.lastName == event.lastNameController.text) {
        lastName = const FormzString.pure();
      } else {
        lastName = FormzString.dirty(event.lastNameController.text);
      }
      status = Formz.validate(
        [
          if (!lastName.pure) lastName,
          if (!state.firstName.pure) state.firstName,
          if (!state.email.pure) state.email,
          if (!state.password.pure) state.password,
          if (!state.positionCode.pure) state.positionCode,
        ],
      );
    } else {
      lastName = FormzString.dirty(event.lastNameController.text);
      status = Formz.validate(
        [
          lastName,
          state.firstName,
          state.email,
          state.password,
          state.positionCode,
        ],
      );
    }

    emit(
      state.copyWith(
        lastName: lastName,
        status: status,
      ),
    );
  }

  void _onEmailChanged(EmailChanged event, Emitter<SystemUserFormState> emit) {
    FormzEmail email;
    FormzStatus status;

    if (selectedSystemUser != null) {
      // This bloc is for updating
      if (selectedSystemUser?.email == event.emailController.text) {
        email = const FormzEmail.pure();
      } else {
        email = FormzEmail.dirty(event.emailController.text);
      }
      status = Formz.validate(
        [
          if (!email.pure) email,
          if (!state.firstName.pure) state.firstName,
          if (!state.lastName.pure) state.lastName,
          if (!state.password.pure) state.password,
          if (!state.positionCode.pure) state.positionCode,
        ],
      );
    } else {
      // this block is new system user.
      email = FormzEmail.dirty(event.emailController.text);
      status = Formz.validate(
        [
          email,
          state.firstName,
          state.lastName,
          state.password,
          state.positionCode,
        ],
      );
    }

    emit(
      state.copyWith(
        email: email,
        status: status,
      ),
    );
  }

  void _onPasswordChanged(
      PasswordChanged event, Emitter<SystemUserFormState> emit) {
    FormzString password;
    FormzStatus status;

    if (selectedSystemUser != null) {
      if (event.passwordController.text.isEmpty) {
        password = const FormzString.pure();
      } else {
        password = FormzString.dirty(event.passwordController.text);
      }
      status = Formz.validate(
        [
          if (!password.pure) password,
          if (!state.firstName.pure) state.firstName,
          if (!state.lastName.pure) state.lastName,
          if (!state.email.pure) state.email,
          if (!state.positionCode.pure) state.positionCode,
        ],
      );
    } else {
      password = FormzString.dirty(event.passwordController.text);
      status = Formz.validate(
        [
          password,
          state.firstName,
          state.lastName,
          state.email,
          state.positionCode,
        ],
      );
    }

    emit(
      state.copyWith(
        password: password,
        status: status,
      ),
    );
  }

  void _onPositionCodeChanged(
      PositionCodeChanged event, Emitter<SystemUserFormState> emit) {
    FormzString positionCode = FormzString.dirty(event.positionCode.text);
    FormzStatus status;

    if (selectedSystemUser != null) {
      // This bloc is for updating
      if (selectedSystemUser?.email == event.positionCode.text) {
        positionCode = const FormzString.pure();
      }
      status = Formz.validate(
        [
          if (!positionCode.pure) positionCode,
          if (!state.firstName.pure) state.firstName,
          if (!state.lastName.pure) state.lastName,
          if (!state.password.pure) state.password,
          if (!state.positionCode.pure) state.positionCode,
        ],
      );
    } else {
      status = Formz.validate(
        [
          state.password,
          state.firstName,
          state.lastName,
          state.email,
          positionCode,
        ],
      );
    }
    emit(
      state.copyWith(
        positionCode: positionCode,
        status: status,
      ),
    );
  }

  void _onCreateButtonSubmitted(
      CreateButtonSubmitted event, Emitter<SystemUserFormState> emit) async {
    Map<String, dynamic> data = {
      "email": state.email.value.toLowerCase(),
      "first_name": state.firstName.value.toTitleCase(),
      "last_name": state.lastName.value.toTitleCase(),
      "is_active": state.isActive.value,
      "position_code": state.positionCode.value,
      "password": state.password.value,
    };
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var message = await systemUserRepo.create(data);
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

  void _onUpdateButtonSubmitted(
      UpdateButtonSubmitted event, Emitter<SystemUserFormState> emit) async {
    Map<String, dynamic> data = {
      "email": state.email.pure
          ? selectedSystemUser?.email
          : state.email.value.toLowerCase(),
      "first_name": state.firstName.pure
          ? selectedSystemUser?.firstName
          : state.firstName.value.toTitleCase(),
      "last_name": state.lastName.pure
          ? selectedSystemUser?.lastName
          : state.lastName.value.toTitleCase(),
      "is_active": state.isActive,
      "position_code": state.positionCode.value,
      "password": (!state.password.pure) ? state.password.value : null,
    };

    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      var message = await systemUserRepo.update(
        id: selectedSystemUser!.id,
        data: data,
      );
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
