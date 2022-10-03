import 'package:formz/formz.dart';

enum FormzStringValidator { empty }

class FormzString extends FormzInput<String, FormzStringValidator> {
  const FormzString.pure() : super.pure('');
  const FormzString.dirty([String value = '']) : super.dirty(value);

  @override
  FormzStringValidator? validator(String? value) {
    return value?.isNotEmpty == true ? null : FormzStringValidator.empty;
  }
}
