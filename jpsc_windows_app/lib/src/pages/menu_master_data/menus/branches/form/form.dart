import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/create_update_bloc/bloc.dart';
import 'form_body.dart';

class BranchFormPage extends StatelessWidget {
  const BranchFormPage({
    Key? key,
    required this.header,
    this.selectedBranch,
    required this.onRefresh,
  }) : super(key: key);

  final String header;
  final BranchModel? selectedBranch;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdateBranchBloc(
        branchRepo: context.read<BranchRepo>(),
        selectedBranch: selectedBranch,
      ),
      child: BlocListener<CreateUpdateBranchBloc, CreateUpdateBranchState>(
        listenWhen: (previous, current) =>
            current.status.isSubmissionFailure ||
            current.status.isSubmissionInProgress ||
            current.status.isSubmissionSuccess,
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
                onRefresh();
                context.router.pop();
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
          content: SingleChildScrollView(
            child: BranchFormBody(selectedBranch: selectedBranch),
          ),
        ),
      ),
    );
  }
}
