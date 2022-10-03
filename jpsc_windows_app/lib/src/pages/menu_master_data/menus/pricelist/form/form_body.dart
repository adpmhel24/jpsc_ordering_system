import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:jpsc_windows_app/src/global_blocs/bloc_pricelist/creating_bloc/bloc.dart';

import '../../../../../data/models/models.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../widgets/custom_dialog.dart';

class PricelistHeaderFormBody extends StatefulWidget {
  const PricelistHeaderFormBody({
    Key? key,
    this.selectedPricelist,
  }) : super(key: key);
  final PricelistModel? selectedPricelist;

  @override
  State<PricelistHeaderFormBody> createState() =>
      _PricelistHeaderFormBodyState();
}

class _PricelistHeaderFormBodyState extends State<PricelistHeaderFormBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late PricelistCreateBloc formBloc;

  bool _isActive = true;

  @override
  void initState() {
    formBloc = context.read<PricelistCreateBloc>();
    final selectedPricelist = widget.selectedPricelist;
    if (selectedPricelist != null) {
      _codeController.text = selectedPricelist.code ?? "";
      _descriptionController.text = selectedPricelist.description ?? "";
      _isActive = selectedPricelist.isActive ?? false;
    }
    formBloc.add(PricelistIsActiveChanged(_isActive));
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext buildContext) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return FractionallySizedBox(
          widthFactor: Responsive.isDesktop(context) ? .5 : 1,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flex(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                direction: Responsive.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  _codeField(),
                  Responsive.isMobile(context)
                      ? Constant.heightSpacer
                      : Constant.widthSpacer,
                  _descriptField(),
                ],
              ),
              Constant.heightSpacer,
              Checkbox(
                checked: _isActive,
                content: const Text("Active"),
                onChanged: (value) {
                  setState(() => _isActive = value!);
                  formBloc.add(PricelistIsActiveChanged(_isActive));
                },
              ),
              const SizedBox(
                height: kPageDefaultVerticalPadding,
              ),
              _createUpdateButton()
            ],
          ),
        );
      },
    );
  }

  Flexible _codeField() {
    return Flexible(
      child: TextFormBox(
        header: "Pricelist Code *",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        onChanged: (_) {
          formBloc.add(PricelistCodeChanged(_codeController.text));
        },
        validator: (_) {
          return formBloc.state.code.invalid ? "Required field!" : null;
        },
      ),
    );
  }

  Flexible _descriptField() {
    return Flexible(
      child: TextFormBox(
        header: "Pricelist Description",
        controller: _descriptionController,
        onChanged: (_) {
          formBloc.add(PricelistDescChanged(_descriptionController.text));
        },
      ),
    );
  }

  MouseRegion _createUpdateButton() {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: FilledButton(
        onPressed: context.watch<PricelistCreateBloc>().state.status.isValidated
            ? () {
                CustomDialogBox.warningMessage(
                  context,
                  message: "Are you sure you want to proceed?",
                  onPositiveClick: (cntx) {
                    if (widget.selectedPricelist != null) {
                      // formBloc.add(
                      //   CreateButtonSubmitted(),
                      // );
                    } else {
                      formBloc.add(
                        PriceListCreateSubmitted(),
                      );
                    }
                    cntx.router.pop();
                  },
                );
              }
            : null,
        child: widget.selectedPricelist != null
            ? const Text("Update")
            : const Text("Create"),
      ),
    );
  }
}
