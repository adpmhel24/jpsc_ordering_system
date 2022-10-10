import 'package:formz/formz.dart';

enum FormzIntValidator { empty }

class FormzInt extends FormzInput<int?, FormzIntValidator> {
  const FormzInt.pure() : super.pure(null);
  const FormzInt.dirty([int? value]) : super.dirty(value);

  @override
  FormzIntValidator? validator(int? value) {
    return value != null && value >= 0 ? null : FormzIntValidator.empty;
  }
}
