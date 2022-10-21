import 'dart:io';

import 'package:fluent_ui/fluent_ui.dart';
// ignore: depend_on_referenced_packages
import 'package:collection/collection.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';
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
  late CurrentUserRepo currUserRepo;

  bool isPasswordHidden = true;

  bool isActive = true;
  bool isSuperAdmin = false;
  bool isFieldEnable = true;

  final ValueNotifier<List<SystemUserPositionModel>> systemUserPositions =
      ValueNotifier([]);

  @override
  void initState() {
    formBloc = context.read<SystemUserFormBloc>();
    currUserRepo = context.read<CurrentUserRepo>();

    if (widget.selectedSystemUser != null) {
      var systemUser = widget.selectedSystemUser!;
      _firstNameController.text = systemUser.firstName;
      _lastNameController.text = systemUser.lastName;
      _emailController.text = systemUser.email;
      _positionCodeController.text = systemUser.positionCode ?? "";
      isActive = systemUser.isActive;
      isSuperAdmin = systemUser.isSuperAdmin;
    }
    loadInitialData();
    isFieldEnable = currUserRepo.currentUser.isSuperAdmin;
    super.initState();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _positionCodeController.dispose();
    systemUserPositions.dispose();
    super.dispose();
  }

  void loadInitialData() async {
    context.loaderOverlay.show();
    final repo = context.read<SystemUserPositionRepo>();
    try {
      await repo.getAll();
      systemUserPositions.value = repo.datas;
      context.loaderOverlay.hide();
    } on HttpException catch (e) {
      CustomDialogBox.errorMessage(context, message: e.message);
      context.loaderOverlay.hide();
    }
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
                crossAxisAlignment: CrossAxisAlignment.start,
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
              Wrap(
                crossAxisAlignment: WrapCrossAlignment.end,
                spacing: 20,
                children: [
                  _positionField(),
                  Checkbox(
                    checked: isActive,
                    onChanged: isFieldEnable
                        ? (v) {
                            setState(() {
                              isActive = v!;
                            });
                            formBloc.add(IsActiveChanged(isActive));
                          }
                        : null,
                    content: Text(isActive ? "Active" : "Inactive"),
                  ),
                  Checkbox(
                    checked: isSuperAdmin,
                    onChanged: currUserRepo.currentUser.isSuperAdmin
                        ? (v) {
                            setState(() {
                              isSuperAdmin = v!;
                            });
                            formBloc.add(IsSuperAdminChanged(isSuperAdmin));
                          }
                        : null,
                    content: const Text("SuperAdmin"),
                  ),
                ],
              ),
              Constant.heightSpacer,
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

  SizedBox _positionField() {
    return SizedBox(
      width: 200,
      child: ValueListenableBuilder<List<SystemUserPositionModel>>(
        valueListenable: systemUserPositions,
        builder: (context, datas, _) {
          return AutoSuggestBox.form(
            autovalidateMode: AutovalidateMode.always,
            controller: _positionCodeController,
            enabled: isFieldEnable,
            items: datas
                .map<AutoSuggestBoxItem>(
                  (e) => AutoSuggestBoxItem(
                    label: "Position *",
                    value: e.code,
                    child: Text(e.code),
                    onSelected: () {
                      _positionCodeController.text = e.code;
                      formBloc.add(
                        PositionCodeChanged(_positionCodeController.text),
                      );
                    },
                  ),
                )
                .toList(),
            onChanged: (value, reason) {
              String? positionCode = datas
                  .firstWhereOrNull((element) => element.code == value)
                  ?.code;
              formBloc.add(
                PositionCodeChanged(positionCode ?? ""),
              );
            },
            validator: (_) {
              return formBloc.state.positionCode.invalid
                  ? "Invalid item position code"
                  : null;
            },
          );
        },
      ),
    );
  }

  MouseRegion _createUpdateButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed:
            context.watch<SystemUserFormBloc>().state.status.isValidated &&
                    isFieldEnable
                ? () {
                    CustomDialogBox.warningMessage(
                      context,
                      message: "Are you sure you want to proceed?",
                      onPositiveClick: (cntx) {
                        formBloc.add(
                          ButtonSubmitted(),
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
        header: "Password *",
        autovalidateMode: AutovalidateMode.always,
        controller: _passwordController,
        obscureText: isPasswordHidden,
        enabled: isFieldEnable,
        onChanged: (_) {
          formBloc.add(
            PasswordChanged(_passwordController.text),
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
        header: "Email *",
        autovalidateMode: AutovalidateMode.always,
        controller: _emailController,
        enabled: isFieldEnable,
        onChanged: (_) {
          formBloc.add(
            EmailChanged(_emailController.text),
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
        header: "Last Name *",
        autovalidateMode: AutovalidateMode.always,
        controller: _lastNameController,
        enabled: isFieldEnable,
        onChanged: (_) {
          formBloc.add(
            LastNameChanged(_lastNameController.text),
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
        header: "First Name *",
        autovalidateMode: AutovalidateMode.always,
        controller: _firstNameController,
        enabled: isFieldEnable,
        onChanged: (_) {
          formBloc.add(
            FirstNameChanged(_firstNameController.text),
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
