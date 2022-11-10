import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/create_update_bloc/bloc.dart';

class BranchFormBody extends StatefulWidget {
  const BranchFormBody({
    Key? key,
    this.selectedBranch,
  }) : super(key: key);
  final BranchModel? selectedBranch;

  @override
  State<BranchFormBody> createState() => _BranchFormBodyState();
}

class _BranchFormBodyState extends State<BranchFormBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _pricelistController = TextEditingController();
  late CreateUpdateBranchBloc formBloc;

  String? _selectedPricelist;

  bool _isActive = true;

  @override
  void initState() {
    formBloc = context.read<CreateUpdateBranchBloc>();
    if (widget.selectedBranch != null) {
      _codeController.text = widget.selectedBranch?.code ?? "";
      _descriptionController.text = widget.selectedBranch?.description ?? "";
      _pricelistController.text = widget.selectedBranch?.pricelistCode ?? "";
      _selectedPricelist = widget.selectedBranch?.pricelistCode ?? "";
      _isActive = widget.selectedBranch?.isActive ?? true;
    }
    fetchPricelist();
    super.initState();
  }

  final ValueNotifier<List<PricelistModel>> _pricelists = ValueNotifier([]);
  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    _pricelistController.dispose();
    _pricelists.dispose();
    super.dispose();
  }

  void fetchPricelist() async {
    var repo = context.read<PricelistRepo>();
    context.loaderOverlay.show();
    if (repo.datas.isEmpty) {
      await repo.getAll();
    }
    _pricelists.value = repo.datas;
    context.loaderOverlay.hide();
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
                  _nameField(),
                  const SizedBox(width: kPageDefaultVerticalPadding),
                  _descriptField(),
                ],
              ),
              Constant.heightSpacer,
              Flex(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  Flexible(
                    child: Checkbox(
                      checked: _isActive,
                      content: const Text("Active"),
                      onChanged: (value) {
                        setState(() => _isActive = value!);
                        formBloc.add(BranchIsActiveChanged(_isActive));
                      },
                    ),
                  ),
                  const SizedBox(width: kPageDefaultVerticalPadding),
                  _pricelistField(),
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

  Flexible _nameField() {
    return Flexible(
      child: TextFormBox(
        header: "Branch Code *",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        onChanged: (value) {
          formBloc.add(BranchCodeChanged(value));
        },
        validator: (_) {
          return formBloc.state.code.invalid ? "Provide branch code." : null;
        },
      ),
    );
  }

  Flexible _descriptField() {
    return Flexible(
      child: TextFormBox(
        header: "Branch Description",
        controller: _descriptionController,
        onChanged: (value) {
          formBloc.add(BranchDescriptionChanged(value));
        },
      ),
    );
  }

  Flexible _pricelistField() {
    return Flexible(
      child: InfoLabel(
        label: "Pricelist",
        child: ValueListenableBuilder<List<PricelistModel>>(
            valueListenable: _pricelists,
            builder: (_, pricelists, __) {
              return AutoSuggestBox.form(
                autovalidateMode: AutovalidateMode.always,
                controller: _pricelistController,
                items: pricelists
                    .map<AutoSuggestBoxItem>(
                      (e) => AutoSuggestBoxItem(
                        label: e.code!,
                        value: e.code!,
                        child: Text(e.code!),
                        onSelected: () {
                          _selectedPricelist = e.code;
                          formBloc.add(
                            BranchPricelistChanged(_selectedPricelist ?? ""),
                          );
                        },
                      ),
                    )
                    .toList(),
                onChanged: (value, reason) {
                  _selectedPricelist = value;
                  if (reason == TextChangedReason.cleared) {
                    formBloc.add(
                      BranchPricelistChanged(_selectedPricelist ?? ""),
                    );
                  }
                },
                validator: (_) {
                  return formBloc.state.pricelistCode.invalid
                      ? "Invalid pricelist code"
                      : null;
                },
              );
            }),
      ),
    );
  }

  MouseRegion _createUpdateButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed:
            context.watch<CreateUpdateBranchBloc>().state.status.isValidated
                ? () {
                    CustomDialogBox.warningMessage(
                      context,
                      message: "Are you sure you want to proceed?",
                      onPositiveClick: (cntx) {
                        formBloc.add(
                          ButtonSubmitted(),
                        );
                      },
                    );
                  }
                : null,
        child: widget.selectedBranch != null
            ? const Text("Update")
            : const Text("Create"),
      ),
    );
  }
}
