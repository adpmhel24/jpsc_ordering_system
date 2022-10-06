import 'package:formz/formz.dart';

enum FormzListValidator { empty }

class FormzList<T> extends FormzInput<List<T>, FormzListValidator> {
  const FormzList.pure() : super.pure(const []);
  const FormzList.dirty([List<T> value = const []]) : super.dirty(value);

  @override
  FormzListValidator? validator(List<T> value) {
    return value.isNotEmpty ? null : FormzListValidator.empty;
  }
}
