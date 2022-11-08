import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import '../blocs/create_update_bloc/bloc.dart';

class UomFormBody extends StatefulWidget {
  const UomFormBody({
    Key? key,
    this.selectedUom,
  }) : super(key: key);
  final UomModel? selectedUom;

  @override
  State<UomFormBody> createState() => _UomFormBodyState();
}

class _UomFormBodyState extends State<UomFormBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late UomFormBloc formBloc;

  bool _isActive = true;

  @override
  void initState() {
    formBloc = context.read<UomFormBloc>();
    if (widget.selectedUom != null) {
      _codeController.text = widget.selectedUom?.code ?? "";
      _descriptionController.text = widget.selectedUom?.description ?? "";
      _isActive = widget.selectedUom?.isActive ?? true;
    }
    formBloc.add(IsActiveChanged(_isActive));
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
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
              Checkbox(
                checked: _isActive,
                content: const Text("Active"),
                onChanged: (value) {
                  setState(() => _isActive = value!);
                  formBloc.add(IsActiveChanged(_isActive));
                },
              ),
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
        header: "Uom Code *",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        onChanged: (_) {
          formBloc.add(CodeChanged(_codeController));
        },
        validator: (_) {
          return formBloc.state.code.invalid ? "Required field." : null;
        },
      ),
    );
  }

  Flexible _descriptField() {
    return Flexible(
      child: TextFormBox(
        header: "Uom Description",
        controller: _descriptionController,
        onChanged: (_) {
          formBloc.add(DescriptionChanged(_descriptionController));
        },
      ),
    );
  }

  MouseRegion _createUpdateButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: context.watch<UomFormBloc>().state.status.isValidated
            ? () {
                CustomDialogBox.warningMessage(
                  context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (cntx) {
                    if (widget.selectedUom != null) {
                      formBloc.add(
                        UpdateButtonSubmitted(),
                      );
                    } else {
                      formBloc.add(
                        CreateButtonSubmitted(),
                      );
                    }
                  },
                );
              }
            : null,
        child: widget.selectedUom != null
            ? const Text("Update")
            : const Text("Create"),
      ),
    );
  }
}
