import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:jpsc_windows_app/src/data/repositories/repos.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

import '../../../../global_blocs/blocs.dart';
import '../../../../router/router.gr.dart';
import '../../../../utils/fetching_status.dart';
import '../../../widgets/custom_dialog.dart';
import '../scaffold_base.dart';
import 'bloc/fetching_bloc/bloc.dart';
import 'components/payment_term_table.dart';

class PaymentTermsPage extends StatefulWidget {
  const PaymentTermsPage({Key? key}) : super(key: key);

  @override
  State<PaymentTermsPage> createState() => _PaymentTermsPageState();
}

class _PaymentTermsPageState extends State<PaymentTermsPage> {
  final GlobalKey<SfDataGridState> sfDataGridKey = GlobalKey<SfDataGridState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          FetchingPaymentTermsBloc(context.read<PaymentTermRepo>())
            ..add(LoadPaymentTerms()),
      child: BlocListener<BranchesBloc, BranchesBlocState>(
        listener: (context, state) {
          if (state.status == FetchingStatus.loading) {
            context.loaderOverlay.show();
          } else if (state.status == FetchingStatus.error) {
            context.loaderOverlay.hide();
            CustomDialogBox.errorMessage(context, message: state.message);
          } else if (state.status == FetchingStatus.success) {
            context.loaderOverlay.hide();
          }
        },
        child: BaseMasterDataScaffold(
          title: "Payment Terms",
          onNewButton: () {
            context.router.navigate(
              PaymentTermWrapper(
                children: [
                  PaymentTermFormRoute(
                    header: "Payment Term Create Form",
                    onRefresh: sfDataGridKey.currentState!.refresh,
                  ),
                ],
              ),
            );
          },
          onRefreshButton: () {
            sfDataGridKey.currentState!.refresh();
          },
          onSearchChanged: (value) {},
          child: PaymentTermTable(
            sfDataGridKey: sfDataGridKey,
          ),
        ),
      ),
    );
  }
}
