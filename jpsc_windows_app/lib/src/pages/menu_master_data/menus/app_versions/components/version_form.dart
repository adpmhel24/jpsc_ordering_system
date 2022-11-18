import 'package:auto_route/auto_route.dart';
import 'package:file_picker/file_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/utils/responsive.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/repositories/repo_app_version.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../../../../../utils/constant.dart';
import '../blocs/create_update_version_bloc/bloc.dart';

class AppVersionFormPage extends StatelessWidget {
  const AppVersionFormPage({
    super.key,
    required this.header,
    required this.onRefresh,
  });

  final String header;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdateAppVersionBloc(
        context.read<AppVersionRepo>(),
      ),
      child:
          BlocListener<CreateUpdateAppVersionBloc, CreateUpdateAppVersionState>(
        listenWhen: (previous, current) =>
            current.status.isSubmissionFailure ||
            current.status.isSubmissionSuccess ||
            current.status.isSubmissionInProgress,
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            CustomDialogBox.successMessage(
              context,
              message: state.message,
              onPositiveClick: (_) {
                context.router.pop();
                onRefresh();
              },
            );
          }
        },
        child: ScaffoldPage.withPadding(
          header: PageHeader(
            leading: CommandBar(
              overflowBehavior: CommandBarOverflowBehavior.noWrap,
              primaryItems: [
                CommandBarBuilderItem(
                  builder: (context, mode, w) => w,
                  wrappedItem: CommandBarButton(
                    icon: const Icon(
                      FluentIcons.back,
                    ),
                    onPressed: () {
                      context.router.pop();
                    },
                  ),
                ),
              ],
            ),
            title: Text(header),
          ),
          content: const AppVersionFormContent(),
        ),
      ),
    );
  }
}

class AppVersionFormContent extends StatefulWidget {
  const AppVersionFormContent({super.key});

  @override
  State<AppVersionFormContent> createState() => _AppVersionFormContentState();
}

class _AppVersionFormContentState extends State<AppVersionFormContent> {
  final TextEditingController _platformController = TextEditingController();
  final TextEditingController _appNameController = TextEditingController();
  final TextEditingController _packageNameController = TextEditingController();
  final TextEditingController _versionController = TextEditingController();
  final TextEditingController _buildNumberController = TextEditingController();

  late CreateUpdateAppVersionBloc _formBloc;

  final List<String> _platforms = [
    "android",
    "macos",
    "ios",
    "windows",
    "web",
    "linux"
  ];

  @override
  void initState() {
    _formBloc = context.read<CreateUpdateAppVersionBloc>();
    super.initState();
  }

  @override
  void dispose() {
    _platformController.dispose();
    _appNameController.dispose();
    _packageNameController.dispose();
    _versionController.dispose();
    _buildNumberController.dispose();
    super.dispose();
  }

  FilePickerResult? pickedFile;

  Future<void> _openApkFile(BuildContext cntx) async {
    try {
      pickedFile = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['apk'],
      );
      if (pickedFile != null && pickedFile!.files.isNotEmpty) {
        _formBloc.add(FileAdded(pickedFile!.files.single));
      }
    } on Exception catch (e) {
      if (mounted) {}
      CustomDialogBox.errorMessage(cntx, message: e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return SizedBox(
        width: Responsive.isDesktop(context) ? constraints.maxWidth * .5 : null,
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
                _packageNameField(),
                Constant.widthSpacer,
                _appNameField()
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
                _versionField(),
                Constant.widthSpacer,
                _buildNumberField(),
                Constant.widthSpacer,
                _platformField(),
              ],
            ),
            Constant.heightSpacer,
            Checkbox(
              content: const Text("Is Active"),
              checked: context
                  .watch<CreateUpdateAppVersionBloc>()
                  .state
                  .isActive
                  .value,
              onChanged: (value) => _formBloc.add(
                IsActiveChanged(value!),
              ),
            ),
            Constant.heightSpacer,
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Button(
                  child: const Text("Attach file *"),
                  onPressed: () {
                    _openApkFile(context);
                  },
                ),
                Constant.widthSpacer,
                Flexible(
                  child: SelectableText(
                    pickedFile?.files.single.name ?? "",
                  ),
                ),
              ],
            ),
            const Spacer(),
            BlocBuilder<CreateUpdateAppVersionBloc,
                CreateUpdateAppVersionState>(
              builder: (context, state) {
                return FilledButton(
                    onPressed: state.status.isValidated
                        ? () {
                            CustomDialogBox.warningMessage(
                              context,
                              message: "Are you sure you want to proceed?",
                              onPositiveClick: (context) =>
                                  _formBloc.add(ButtonSubmitted()),
                            );
                          }
                        : null,
                    child: const Text("Add"));
              },
            )
          ],
        ),
      );
    });
  }

  Flexible _buildNumberField() {
    return Flexible(
      child: TextFormBox(
        autovalidateMode: AutovalidateMode.always,
        header: "Build Number *",
        controller: _buildNumberController,
        onChanged: (value) => _formBloc.add(BuildNumberChanged(value)),
        validator: (value) =>
            _formBloc.state.buildNumber.invalid ? "Required field" : null,
      ),
    );
  }

  Flexible _versionField() {
    return Flexible(
      child: TextFormBox(
        autovalidateMode: AutovalidateMode.always,
        header: "Version *",
        controller: _versionController,
        onChanged: (value) => _formBloc.add(VersionChanged(value)),
        validator: (value) =>
            _formBloc.state.version.invalid ? "Required field" : null,
      ),
    );
  }

  Flexible _appNameField() {
    return Flexible(
      child: TextFormBox(
        autovalidateMode: AutovalidateMode.always,
        header: "App Name *",
        controller: _appNameController,
        onChanged: (value) => _formBloc.add(AppNameChanged(value)),
        validator: (value) =>
            _formBloc.state.appName.invalid ? "Required field" : null,
      ),
    );
  }

  Flexible _packageNameField() {
    return Flexible(
      child: TextFormBox(
        autovalidateMode: AutovalidateMode.always,
        header: "Package Name *",
        controller: _packageNameController,
        onChanged: (value) => _formBloc.add(PackageNameChanged(value)),
        validator: (_) =>
            _formBloc.state.packageName.invalid ? "Required field!" : null,
      ),
    );
  }

  Flexible _platformField() {
    return Flexible(
        child: InfoLabel(
      label: "Platform *",
      child: AutoSuggestBox.form(
        autovalidateMode: AutovalidateMode.always,
        controller: _platformController,
        items: _platforms
            .map<AutoSuggestBoxItem>(
              (e) => AutoSuggestBoxItem(
                label: e,
                value: e,
                child: Text(e),
                onSelected: () {
                  _formBloc.add(
                    PlatformChanged(e),
                  );
                },
              ),
            )
            .toList(),
        onChanged: (value, reason) {
          if (reason == TextChangedReason.cleared) {
            _formBloc.add(
              PlatformChanged(value),
            );
          }
        },
        validator: (v) {
          return _formBloc.state.platform.invalid || !_platforms.contains(v)
              ? "Invalid platform"
              : null;
        },
      ),
    ));
  }
}
