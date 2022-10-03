import 'package:formz/formz.dart';

enum FormzEmailValidator { invalid }

class FormzEmail extends FormzInput<String, FormzEmailValidator> {
  const FormzEmail.pure() : super.pure('');
  const FormzEmail.dirty([String value = '']) : super.dirty(value);

  @override
  FormzEmailValidator? validator(String? value) {
    RegExp emailRegExp = RegExp(
        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    try {
      if (emailRegExp.hasMatch(value ?? "")) {
        return null;
      } else {
        return FormzEmailValidator.invalid;
      }
    } on Exception catch (_) {
      return FormzEmailValidator.invalid;
    }
  }
}
