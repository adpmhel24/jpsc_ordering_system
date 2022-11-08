import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../bloc/create_update_bloc/bloc.dart';
import 'form_body.dart';

class PaymentTermFormPage extends StatelessWidget {
  const PaymentTermFormPage({
    Key? key,
    required this.header,
    this.selectedPayTermObj,
    required this.onRefresh,
  }) : super(key: key);

  final String header;
  final PaymentTermModel? selectedPayTermObj;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdatePaymentTermBloc(
        repo: context.read<PaymentTermRepo>(),
        payTermObj: selectedPayTermObj,
      ),
      child: BlocListener<CreateUpdatePaymentTermBloc,
          CreateUpdatePaymentTermState>(
        listenWhen: (previous, current) => previous.status != current.status,
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
            child: PaymentTermFormBody(selectedPayTermObj: selectedPayTermObj),
          ),
        ),
      ),
    );
  }
}
