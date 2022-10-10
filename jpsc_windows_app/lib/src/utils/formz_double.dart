import 'package:formz/formz.dart';

enum FormzDoubleValidator { empty }

class FormzDouble extends FormzInput<double?, FormzDoubleValidator> {
  const FormzDouble.pure() : super.pure(null);
  const FormzDouble.dirty([double? value]) : super.dirty(value);

  @override
  FormzDoubleValidator? validator(double? value) {
    return value != null && value >= 0 ? null : FormzDoubleValidator.empty;
  }
}
