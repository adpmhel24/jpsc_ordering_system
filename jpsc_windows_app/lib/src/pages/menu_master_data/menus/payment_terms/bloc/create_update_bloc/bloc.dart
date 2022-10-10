import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/formz_string.dart';

part 'event.dart';
part 'state.dart';

class CreateUpdatePaymentTermBloc
    extends Bloc<CreateUpdatePaymentTermEvent, CreateUpdatePaymentTermState> {
  final PaymentTermModel? payTermObj;
  final PaymentTermRepo repo;

  CreateUpdatePaymentTermBloc({
    required this.repo,
    this.payTermObj,
  }) : super(
          payTermObj != null
              ? CreateUpdatePaymentTermState(
                  code: FormzString.dirty(payTermObj.code),
                  description: FormzString.dirty(payTermObj.description ?? ""),
                  status: FormzStatus.valid,
                )
              : const CreateUpdatePaymentTermState(),
        ) {
    on<PayTermCodeChanged>(_onPayTermCodeChanged);
    on<PayTermDescriptionChanged>(_onPayTermDescriptionChanged);
    on<CreateUpadteSubmitted>(_onCreateUpadteSubmitted);
  }

  void _onPayTermCodeChanged(
      PayTermCodeChanged event, Emitter<CreateUpdatePaymentTermState> emit) {
    final code = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        code: code,
        status: Formz.validate(
          [
            code,
          ],
        ),
      ),
    );
  }

  void _onPayTermDescriptionChanged(PayTermDescriptionChanged event,
      Emitter<CreateUpdatePaymentTermState> emit) {
    final description = FormzString.dirty(event.value);
    emit(
      state.copyWith(
        description: description,
        status: Formz.validate(
          [
            state.code,
          ],
        ),
      ),
    );
  }

  void _onCreateUpadteSubmitted(CreateUpadteSubmitted event,
      Emitter<CreateUpdatePaymentTermState> emit) async {
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    String message;

    Map<String, dynamic> data = {
      "code": state.code.value,
      "description": state.description.value,
    };

    try {
      if (payTermObj != null) {
        message = await repo.update(fk: payTermObj!.code, data: data);
      } else {
        message = await repo.create(data);
      }
      emit(
        state.copyWith(
          status: FormzStatus.submissionSuccess,
          message: message,
        ),
      );
    } on HttpException catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          message: e.message,
        ),
      );
    }
  }
}
