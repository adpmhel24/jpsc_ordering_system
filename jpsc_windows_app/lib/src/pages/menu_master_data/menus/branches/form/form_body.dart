import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart' as m;
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';
import '../../../../widgets/custom_dropdown_search.dart';
import 'bloc/bloc.dart';

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
  late BranchFormBloc formBloc;

  PricelistModel? _selectedPricelist;

  bool _isActive = true;

  @override
  void initState() {
    formBloc = context.read<BranchFormBloc>();
    if (widget.selectedBranch != null) {
      _codeController.text = widget.selectedBranch?.code ?? "";
      _descriptionController.text = widget.selectedBranch?.description ?? "";
      _pricelistController.text = widget.selectedBranch?.pricelistCode ?? "";
      _isActive = widget.selectedBranch?.isActive ?? true;
    }
    formBloc.add(BranchIsActiveChanged(_isActive));
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    _pricelistController.dispose();
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
        onChanged: (_) {
          formBloc.add(BranchCodeChanged(_codeController));
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
        onChanged: (_) {
          formBloc.add(BranchDescriptionChanged(_descriptionController));
        },
      ),
    );
  }

  Flexible _pricelistField() {
    return Flexible(
      child: InfoLabel(
        label: "Pricelist Code",
        child: m.Material(
          child: MyCustomDropdownSearch<PricelistModel>(
            selectedItem: _selectedPricelist,
            itemAsString: (pricelist) => pricelist!.code!,
            onFind: (String? filter) =>
                context.read<PricelistRepo>().offlineSearch(filter!),
            compareFn: (item, selectedItem) => item!.code == selectedItem!.code,
            onChanged: (PricelistModel? data) {
              _pricelistController.text = data?.code ?? "";
              formBloc.add(
                BranchPricelistChanged(_pricelistController),
              );
            },
          ),
        ),
      ),
    );
  }

  MouseRegion _createUpdateButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: context.watch<BranchFormBloc>().state.status.isValidated
            ? () {
                CustomDialogBox.warningMessage(
                  context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (cntx) {
                    if (widget.selectedBranch != null) {
                      formBloc.add(
                        UpdateButtonSubmitted(),
                      );
                    } else {
                      formBloc.add(
                        CreateButtonSubmitted(),
                      );
                    }
                    Navigator.of(cntx).pop();
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
