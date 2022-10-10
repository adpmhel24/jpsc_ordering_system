import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../global_bloc/bloc_auth/bloc.dart';
import '../../utils/constant.dart';
import '../bloc/login_bloc.dart';
import 'login_form.dart';

class LoginBody extends StatelessWidget {
  const LoginBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DoubleBackToCloseApp(
        snackBar: const SnackBar(
          content: Text('Tap back again to leave'),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 20),
              child: Padding(
                padding: EdgeInsets.only(
                  left: 24,
                  right: 24,
                  bottom: MediaQuery.of(context).viewPadding.bottom,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 100),
                    AspectRatio(
                      aspectRatio: 4 / 2,
                      child: SizedBox(
                        height: 200,
                        width: 300,
                        child: Image.asset(
                          'assets/images/logo.png',
                          fit: BoxFit.fitWidth,
                        ),
                      ),
                    ),
                    Constant.heightSpacer,
                    Text("JPSC System",
                        style: Theme.of(context).textTheme.titleMedium),
                    Constant.heightSpacer,
                    const LoginForm(),
                    const SizedBox(
                      height: Constant.minPadding * 3,
                    ),
                    const SizedBox(
                      height: Constant.minPadding * 3,
                    ),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: (context
                                .watch<LoginFormBloc>()
                                .state
                                .status
                                .isValidated)
                            ? () {
                                var loginFormState =
                                    context.read<LoginFormBloc>().state;
                                context.read<AuthBloc>().add(
                                      LoginSubmitted(
                                        username: loginFormState.username.value,
                                        password: loginFormState.password.value,
                                      ),
                                    );
                              }
                            : null,
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
