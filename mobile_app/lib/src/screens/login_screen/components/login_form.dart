import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../utils/constant.dart';
import '../bloc/login_bloc.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _branchCodeController = TextEditingController();

  bool _isPasswordHidden = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _branchCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginFormBloc, LoginFormState>(
      builder: (context, state) {
        return Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.always,
              controller: _usernameController,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                filled: true,
                labelText: "Email",
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              ),
              onChanged: (value) {
                context.read<LoginFormBloc>().add(LoginUsernameChanged(value));
              },
              validator: (_) {
                return (state.username.invalid) ? "Required Field" : null;
              },
              onEditingComplete: () {},
            ),
            Constant.heightSpacer,
            TextFormField(
              controller: _passwordController,
              autovalidateMode: AutovalidateMode.always,
              obscureText: _isPasswordHidden,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: Colors.transparent, width: 0),
                ),
                filled: true,
                labelText: "Password",
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                suffixIcon: IconButton(
                  icon: _isPasswordHidden
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  onPressed: () {
                    setState(() {
                      _isPasswordHidden = !_isPasswordHidden;
                    });
                  },
                ),
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
              ),
              onChanged: (value) {
                context.read<LoginFormBloc>().add(LoginPasswordChanged(value));
              },
              validator: (_) {
                return (state.password.invalid) ? "Required Field" : null;
              },
            ),
          ],
        );
      },
    );
  }
}
