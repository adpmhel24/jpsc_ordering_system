import 'package:formz/formz.dart';

enum FormzValidator { empty }

class FormzFile<T> extends FormzInput<T?, FormzValidator> {
  const FormzFile.pure() : super.pure(null);
  const FormzFile.dirty([T? value]) : super.dirty(value);

  @override
  FormzValidator? validator(T? value) {
    return value != null ? null : FormzValidator.empty;
  }
}
