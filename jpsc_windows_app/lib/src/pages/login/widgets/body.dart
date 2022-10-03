import 'package:fluent_ui/fluent_ui.dart';

import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 200,
            width: 300,
            child: Image.asset(
              'assets/images/logo.png',
              fit: BoxFit.fitWidth,
            ),
          ),
          const SizedBox(
            height: 250,
            width: 300,
            child: LoginForm(),
          ),
        ],
      ),
    );
  }
}
