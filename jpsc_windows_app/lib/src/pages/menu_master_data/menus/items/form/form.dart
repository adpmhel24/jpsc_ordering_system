import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../global_blocs/blocs.dart';
import '../../../../widgets/custom_dialog.dart';
import 'bloc/itemform_bloc.dart';
import 'form_body.dart';

class ItemFormPage extends StatelessWidget {
  const ItemFormPage({
    Key? key,
    required this.header,
    this.selectedItem,
  }) : super(key: key);

  final String header;
  final ProductModel? selectedItem;

  void _loadData(BuildContext context) {
    context.read<ItemsBloc>().add(LoadItems());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ItemFormBloc(
        itemRepo: context.read<ProductRepo>(),
        selectedItem: selectedItem,
      ),
      child: BlocListener<ItemFormBloc, ItemFormState>(
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
          content: SingleChildScrollView(
            child: ItemFormBody(selectedItem: selectedItem),
          ),
        ),
      ),
    );
  }
}
