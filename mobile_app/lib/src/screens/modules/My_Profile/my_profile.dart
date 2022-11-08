import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_app/src/screens/widgets/custom_animated_dialog.dart';

import '../../../data/models/models.dart';
import '../../../data/repositories/repos.dart';
import '../../utils/constant.dart';
import '../../widgets/custom_text_field.dart';
import 'blocs/change_password_bloc/bloc.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  late SystemUserModel currUser;

  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  @override
  void initState() {
    currUser = context.read<CurrentUserRepo>().currentUser;
    _firstNameController.text = currUser.firstName;
    _lastNameController.text = currUser.lastName;
    _emailController.text = currUser.email;

    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          CustomTextField(
            labelText: "First Name",
            controller: _firstNameController,
            enabled: false,
          ),
          Constant.heightSpacer,
          CustomTextField(
            labelText: "Last Name",
            controller: _lastNameController,
            enabled: false,
          ),
          Constant.heightSpacer,
          CustomTextField(
            labelText: "Email Address",
            controller: _emailController,
            enabled: false,
          ),
          Constant.heightSpacer,
          TextButton(
              onPressed: () {
                showAnimatedDialog(
                    context: context,
                    builder: (_) {
                      return ChangePasswordDialog(
                        systemUserRepo: context.read<SystemUserRepo>(),
                      );
                    });
              },
              child: const Text("Change Password"))
        ],
      ),
    );
  }
}

class ChangePasswordDialog extends StatefulWidget {
  const ChangePasswordDialog({
    super.key,
    required this.systemUserRepo,
  });

  final SystemUserRepo systemUserRepo;

  @override
  State<ChangePasswordDialog> createState() => _ChangePasswordDialogState();
}

class _ChangePasswordDialogState extends State<ChangePasswordDialog> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool passwordHidden = true;
  bool confirmPasswordHidden = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ChangePasswordBloc(
        widget.systemUserRepo,
      ),
      child: BlocConsumer<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            CustomAnimatedDialog.error(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            CustomAnimatedDialog.success(
                context: context,
                message: state.message,
                onPositiveClick: (cntx) {
                  Navigator.of(cntx).pop();
                });
          }
        },
        builder: (context, state) {
          return CustomDialogWidget(
            title: const Text("Changed Password"),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Close"),
              ),
              ElevatedButton(
                onPressed:
                    context.watch<ChangePasswordBloc>().state.status.isValidated
                        ? () {
                            CustomAnimatedDialog.warning(
                              context,
                              message: "Are you sure you want to proceed?",
                              onPositiveClick: (cntx) {
                                context.read<ChangePasswordBloc>().add(
                                      ButtonSubmitted(),
                                    );
                              },
                            );
                          }
                        : null,
                child: const Text("Update"),
              ),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTextField(
                  autovalidateMode: AutovalidateMode.always,
                  labelText: "Password",
                  controller: _passwordController,
                  obscureText: passwordHidden,
                  maxLines: 1,
                  suffixIcon: IconButton(
                    icon: Icon(passwordHidden
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        passwordHidden = !passwordHidden;
                      });
                    },
                  ),
                  onChanged: (value) => context
                      .read<ChangePasswordBloc>()
                      .add(PasswordFieldChanged(value)),
                  validator: (value) =>
                      state.password.invalid ? "Required field!" : null,
                ),
                Constant.heightSpacer,
                CustomTextField(
                  autovalidateMode: AutovalidateMode.always,
                  labelText: "Confirm Password",
                  controller: _confirmPasswordController,
                  obscureText: confirmPasswordHidden,
                  maxLines: 1,
                  suffixIcon: IconButton(
                    icon: Icon(confirmPasswordHidden
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () {
                      setState(() {
                        confirmPasswordHidden = !confirmPasswordHidden;
                      });
                    },
                  ),
                  onChanged: (value) => context
                      .read<ChangePasswordBloc>()
                      .add(ConfirmPasswordFieldChanged(value)),
                  validator: (value) {
                    final password = state.password;
                    final confirmPassword = state.confirmPassword;

                    return confirmPassword.invalid
                        ? "Required field!"
                        : password.value != confirmPassword.value
                            ? "Confirm password doesn't match!"
                            : null;
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
