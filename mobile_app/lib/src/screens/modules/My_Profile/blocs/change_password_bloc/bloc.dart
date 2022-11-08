import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/repositories/repos.dart';
import '../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  SystemUserRepo systemUserRepo;
  ChangePasswordBloc(this.systemUserRepo) : super(const ChangePasswordState()) {
    on<PasswordFieldChanged>(onPasswordFieldChanged);
    on<ConfirmPasswordFieldChanged>(onConfirmPasswordFieldChanged);
    on<ButtonSubmitted>(onButtonSubmitted);
  }

  void onPasswordFieldChanged(
      PasswordFieldChanged event, Emitter<ChangePasswordState> emit) {
    final password = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        password: password,
        status: password.value != state.confirmPassword.value
            ? FormzStatus.invalid
            : Formz.validate(
                [
                  password,
                  state.confirmPassword,
                ],
              ),
      ),
    );
  }

  void onConfirmPasswordFieldChanged(
      ConfirmPasswordFieldChanged event, Emitter<ChangePasswordState> emit) {
    final confirmPassword = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        confirmPassword: confirmPassword,
        status: confirmPassword.value != state.password.value
            ? FormzStatus.invalid
            : Formz.validate(
                [
                  state.password,
                  confirmPassword,
                ],
              ),
      ),
    );
  }

  void onButtonSubmitted(
      ButtonSubmitted event, Emitter<ChangePasswordState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));

    Map<String, dynamic> data = {
      "password": state.password.value,
      "confirm_password": state.confirmPassword.value,
    };

    try {
      String message = await systemUserRepo.changePassword(data);
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
