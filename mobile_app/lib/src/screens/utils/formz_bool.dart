import 'package:formz/formz.dart';

enum FormzBoolValidator { invalid }

class FormzBool extends FormzInput<bool?, FormzBoolValidator> {
  const FormzBool.pure() : super.pure(null);
  const FormzBool.dirty(bool? value) : super.dirty(value);

  @override
  FormzBoolValidator? validator(bool? value) {
    return value != null ? null : FormzBoolValidator.invalid;
  }
}
