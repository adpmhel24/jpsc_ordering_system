import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/shared/widgets/custom_dialog.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../utils/constant.dart';
import '../../blocs/creating_update_bloc/bloc.dart';
import 'address_form_modal.dart';
import 'address_table.dart';

part 'form_body.dart';

class CustomerFormPage extends StatelessWidget {
  const CustomerFormPage({
    Key? key,
    required this.header,
    this.selectedCustomer,
    required this.onRefresh,
  }) : super(key: key);
  final String header;
  final CustomerModel? selectedCustomer;
  final void Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateUpdateCustomerBloc(
        customerRepo: context.read<CustomerRepo>(),
        selectedCustomer: selectedCustomer,
      ),
      child: BlocListener<CreateUpdateCustomerBloc, CreateUpdateCustomerState>(
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
              onPositiveClick: (cntx) {
                cntx.router.pop(); // pop the dialog
                onRefresh();
                context.router.pop(); // pop the form
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
          content: CustomerFormBody(
            selectedCustomer: selectedCustomer,
          ),
        ),
      ),
    );
  }
}
