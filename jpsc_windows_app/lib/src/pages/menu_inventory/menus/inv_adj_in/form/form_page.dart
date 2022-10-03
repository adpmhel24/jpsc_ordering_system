import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/repositories/repos.dart';
import '../../../../widgets/custom_dialog.dart';
import '../bloc/inv_adj_in_bloc.dart';
import 'bloc/bloc.dart';
import 'form_body.dart';

class InvAdjustmentInFormPage extends StatelessWidget {
  const InvAdjustmentInFormPage({
    Key? key,
    required this.header,
    required this.invAdjInbloc,
  }) : super(key: key);

  final String header;
  final InvAdjustmentInBloc invAdjInbloc;

  void _loadData(BuildContext context) {
    invAdjInbloc.add(RefreshInvAdjIn());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          InvAdjustmentInFormBloc(context.read<InvAdjustmentInRepo>()),
      child: BlocListener<InvAdjustmentInFormBloc, InvAdjustmentInFormState>(
        listenWhen: (previous, current) =>
            current.status.isSubmissionFailure ||
            current.status.isSubmissionInProgress ||
            current.status.isSubmissionSuccess,
        listener: (_, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context,
                message: state.responseMessage);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            CustomDialogBox.successMessage(
              context,
              message: state.responseMessage,
              onPositiveClick: (_) {
                _loadData(context);
                context.router.pop(); //to pop the form
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
          content: const InvAdjustmentInFormBody(),
        ),
      ),
    );
  }
}
