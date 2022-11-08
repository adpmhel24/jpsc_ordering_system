import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../data/models/models.dart';
import '../../data/repositories/repos.dart';
import '../../shared/widgets/custom_button.dart';
import '../../shared/widgets/custom_dialog.dart';
import '../../utils/constant.dart';
import 'blocs/change_password_bloc/bloc.dart';

class MyProfilePage extends StatelessWidget {
  const MyProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.withPadding(
      header: const PageHeader(title: Text("My Profile")),
      content: const MyProfilePageContent(),
    );
  }
}

class MyProfilePageContent extends StatefulWidget {
  const MyProfilePageContent({Key? key}) : super(key: key);

  @override
  State<MyProfilePageContent> createState() => _MyProfilePageContentState();
}

class _MyProfilePageContentState extends State<MyProfilePageContent> {
  late SystemUserModel currUser;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _positionController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    currUser = context.read<CurrentUserRepo>().currentUser;
    _emailController.text = currUser.email;
    _firstNameController.text = currUser.firstName;
    _lastNameController.text = currUser.lastName;
    _positionController.text = currUser.positionCode ?? "";
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _positionController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SizedBox(
              width: 300,
              child: TextFormBox(
                header: "First Name",
                controller: _firstNameController,
                enabled: false,
              ),
            ),
          ),
          Constant.widthSpacer,
          Flexible(
            child: SizedBox(
              width: 300,
              child: TextFormBox(
                enabled: false,
                header: "Last Name",
                controller: _lastNameController,
              ),
            ),
          ),
        ],
      ),
      Constant.heightSpacer,
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: SizedBox(
              width: 300,
              child: TextFormBox(
                header: "Email Address",
                controller: _emailController,
                enabled: false,
              ),
            ),
          ),
          Constant.widthSpacer,
          Flexible(
            child: SizedBox(
              width: 300,
              child: CustomTextButton(
                child: const Text("Changed Password"),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) => ChangePasswordDialogContent(
                      systemUserRepo: context.read<SystemUserRepo>(),
                    ),
                  );
                },
              ),
            ),
          )
        ],
      )
    ]);
  }
}

class ChangePasswordDialogContent extends StatefulWidget {
  const ChangePasswordDialogContent({
    Key? key,
    required this.systemUserRepo,
  }) : super(key: key);

  final SystemUserRepo systemUserRepo;

  @override
  State<ChangePasswordDialogContent> createState() =>
      _ChangePasswordDialogContentState();
}

class _ChangePasswordDialogContentState
    extends State<ChangePasswordDialogContent> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  bool isHiddenFirstPw = true;
  bool isHiddenConfirmPw = true;

  bool isInit = true;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChangePasswordBloc(widget.systemUserRepo),
      child: BlocListener<ChangePasswordBloc, ChangePasswordState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            CustomDialogBox.successMessage(context, message: state.message,
                onPositiveClick: (cntx) {
              Navigator.of(cntx).pop();
            });
          }
        },
        child: Builder(builder: (context) {
          return ContentDialog(
            title: const Text("Change Password"),
            actions: [
              CustomButton(
                child: const Text("Close"),
                onPressed: () => Navigator.of(context).pop(),
              ),
              BlocBuilder<ChangePasswordBloc, ChangePasswordState>(
                builder: (_, state) {
                  return CustomFilledButton(
                    onPressed: state.status.isValidated
                        ? () {
                            CustomDialogBox.warningMessage(context,
                                message: "Are you sure you want to proceed?",
                                onPositiveClick: (_) => context
                                    .read<ChangePasswordBloc>()
                                    .add(ButtonSubmitted()));
                          }
                        : null,
                    child: const Text("Update"),
                  );
                },
              ),
            ],
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormBox(
                  autovalidateMode: AutovalidateMode.always,
                  header: "Password *",
                  controller: _passwordController,
                  obscureText: isHiddenFirstPw,
                  onChanged: (value) {
                    context
                        .read<ChangePasswordBloc>()
                        .add(PasswordFieldChanged(value));
                  },
                  validator: (value) =>
                      context.read<ChangePasswordBloc>().state.password.invalid
                          ? "Required field!"
                          : null,
                  suffix: IconButton(
                    icon: Icon(
                        isHiddenFirstPw ? FluentIcons.hide : FluentIcons.view),
                    onPressed: () {
                      setState(() {
                        isHiddenFirstPw = !isHiddenFirstPw;
                      });
                    },
                  ),
                ),
                Constant.heightSpacer,
                TextFormBox(
                  autovalidateMode: AutovalidateMode.always,
                  header: "Confirm Password *",
                  obscureText: isHiddenConfirmPw,
                  controller: _confirmPasswordController,
                  onChanged: (value) {
                    context
                        .read<ChangePasswordBloc>()
                        .add(ConfirmPasswordFieldChanged(value));
                  },
                  validator: (value) {
                    final password =
                        context.read<ChangePasswordBloc>().state.password;
                    final confirmPassword = context
                        .read<ChangePasswordBloc>()
                        .state
                        .confirmPassword;

                    return confirmPassword.invalid
                        ? "Required field!"
                        : password.value != confirmPassword.value
                            ? "Confirm password doesn't match!"
                            : null;
                  },
                  suffix: IconButton(
                    icon: Icon(isHiddenConfirmPw
                        ? FluentIcons.hide
                        : FluentIcons.view),
                    onPressed: () {
                      setState(() {
                        isHiddenConfirmPw = !isHiddenConfirmPw;
                      });
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
