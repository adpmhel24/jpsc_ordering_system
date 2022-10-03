import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_dropdown_search.dart';
import 'bloc/bloc.dart';

class SystemUserFormBody extends StatefulWidget {
  const SystemUserFormBody({
    Key? key,
    this.selectedSystemUser,
  }) : super(key: key);

  final SystemUserModel? selectedSystemUser;

  @override
  State<SystemUserFormBody> createState() => _SystemUserFormBodyState();
}

class _SystemUserFormBodyState extends State<SystemUserFormBody> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _positionCodeController = TextEditingController();
  late SystemUserFormBloc formBloc;

  bool isPasswordHidden = true;

  @override
  void initState() {
    formBloc = context.read<SystemUserFormBloc>();

    if (widget.selectedSystemUser != null) {
      var systemUser = widget.selectedSystemUser!;
      _firstNameController.text = systemUser.firstName;
      _lastNameController.text = systemUser.lastName;
      _emailController.text = systemUser.email;
      _positionCodeController.text = systemUser.positionCode ?? "";
    }
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _positionCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return SizedBox(
          width: Responsive.isDesktop(context)
              ? constraints.maxWidth * .5
              : constraints.maxWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  _firstNameField(),
                  const SizedBox(width: kPageDefaultVerticalPadding),
                  _lastNameField(),
                ],
              ),
              Constant.heightSpacer,
              Flex(
                mainAxisSize: MainAxisSize.min,
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  _emailField(),
                  const SizedBox(width: kPageDefaultVerticalPadding),
                  _passwordField(),
                ],
              ),
              Constant.heightSpacer,
              _positionCodeField(context),
              const SizedBox(
                height: kPageDefaultVerticalPadding,
              ),
              _createUpdateButton(context)
            ],
          ),
        );
      },
    );
  }

  InfoLabel _positionCodeField(BuildContext context) {
    return InfoLabel(
      label: "Position Code",
      child: m.Material(
        child: MyCustomDropdownSearch<SystemUserPositionModel>(
          autoValidateMode: AutovalidateMode.always,
          itemAsString: (position) => position!.code,
          onFind: (String? filter) =>
              context.read<SystemUserPositionRepo>().offlineSearch(filter!),
          compareFn: (position, selectedPosition) =>
              position!.code == selectedPosition!.code,
          onChanged: (SystemUserPositionModel? data) {
            _positionCodeController.text = data?.code ?? "";
            formBloc.add(
              PositionCodeChanged(_positionCodeController),
            );
          },
        ),
      ),
    );
  }

  MouseRegion _createUpdateButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: context.watch<SystemUserFormBloc>().state.status.isValidated
            ? () {
                CustomDialogBox.warningMessage(
                  context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (cntx) {
                    formBloc.add(
                      CreateButtonSubmitted(),
                    );
                    Navigator.of(cntx).pop();
                  },
                );
              }
            : null,
        child: widget.selectedSystemUser != null
            ? const Text("Update")
            : const Text("Create"),
      ),
    );
  }

  Flexible _passwordField() {
    return Flexible(
      child: TextFormBox(
        header: "Password",
        autovalidateMode: AutovalidateMode.always,
        controller: _passwordController,
        obscureText: isPasswordHidden,
        onChanged: (_) {
          formBloc.add(
            PasswordChanged(_passwordController),
          );
        },
        validator: (_) {
          return formBloc.state.password.invalid ? "Provide password." : null;
        },
        suffix: IconButton(
          icon: Icon(
            isPasswordHidden ? FluentIcons.lock : FluentIcons.unlock,
          ),
          onPressed: () => setState(() => isPasswordHidden = !isPasswordHidden),
        ),
      ),
    );
  }

  Flexible _emailField() {
    return Flexible(
      child: TextFormBox(
        header: "Email",
        autovalidateMode: AutovalidateMode.always,
        controller: _emailController,
        onChanged: (_) {
          formBloc.add(
            EmailChanged(_emailController),
          );
        },
        validator: (_) {
          return formBloc.state.email.invalid ? "Invalid email." : null;
        },
      ),
    );
  }

  Flexible _lastNameField() {
    return Flexible(
      child: TextFormBox(
        header: "Last Name",
        autovalidateMode: AutovalidateMode.always,
        controller: _lastNameController,
        onChanged: (_) {
          formBloc.add(
            LastNameChanged(_lastNameController),
          );
        },
        validator: (_) {
          return formBloc.state.lastName.invalid ? "Provide last name." : null;
        },
      ),
    );
  }

  Flexible _firstNameField() {
    return Flexible(
      child: TextFormBox(
        header: "First Name",
        autovalidateMode: AutovalidateMode.always,
        controller: _firstNameController,
        onChanged: (_) {
          formBloc.add(
            FirstNameChanged(_firstNameController),
          );
        },
        validator: (_) {
          return formBloc.state.firstName.invalid
              ? "Provide first name."
              : null;
        },
      ),
    );
  }
}
