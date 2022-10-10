import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';
import '../bloc/create_update_bloc/bloc.dart';

class PaymentTermFormBody extends StatefulWidget {
  const PaymentTermFormBody({
    Key? key,
    this.selectedPayTermObj,
  }) : super(key: key);
  final PaymentTermModel? selectedPayTermObj;

  @override
  State<PaymentTermFormBody> createState() => _PaymentTermFormBodyState();
}

class _PaymentTermFormBodyState extends State<PaymentTermFormBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late CreateUpdatePaymentTermBloc formBloc;

  @override
  void initState() {
    formBloc = context.read<CreateUpdatePaymentTermBloc>();
    if (widget.selectedPayTermObj != null) {
      _codeController.text = widget.selectedPayTermObj?.code ?? "";
      _descriptionController.text =
          widget.selectedPayTermObj?.description ?? "";
    }
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
                  _codeField(),
                  const SizedBox(width: kPageDefaultVerticalPadding),
                  _descriptField(),
                ],
              ),
              Constant.heightSpacer,
              _createUpdateButton(context)
            ],
          ),
        );
      },
    );
  }

  Flexible _codeField() {
    return Flexible(
      child: TextFormBox(
        header: "Payment Term Code *",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        onChanged: (_) {
          formBloc.add(PayTermCodeChanged(_codeController.text));
        },
        validator: (_) {
          return formBloc.state.code.invalid ? "Requierd field." : null;
        },
      ),
    );
  }

  Flexible _descriptField() {
    return Flexible(
      child: TextFormBox(
        header: "Payment Term Description",
        controller: _descriptionController,
        onChanged: (_) {
          formBloc.add(PayTermDescriptionChanged(_descriptionController.text));
        },
      ),
    );
  }

  MouseRegion _createUpdateButton(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: context
                .watch<CreateUpdatePaymentTermBloc>()
                .state
                .status
                .isValidated
            ? () {
                CustomDialogBox.warningMessage(
                  context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (cntx) {
                    formBloc.add(CreateUpadteSubmitted());
                    Navigator.of(cntx).pop();
                  },
                );
              }
            : null,
        child: widget.selectedPayTermObj != null
            ? const Text("Update")
            : const Text("Create"),
      ),
    );
  }
}
