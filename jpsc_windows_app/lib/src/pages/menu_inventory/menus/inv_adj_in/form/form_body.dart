import 'package:date_time_picker/date_time_picker.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' as m;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

import '../../../../../data/repositories/repos.dart';
import '../../../../../shared/widgets/custom_button.dart';
import '../../../../../utils/constant.dart';
import '../../../../../utils/responsive.dart';
import '../../../../../shared/widgets/custom_dialog.dart';
import 'bloc/bloc.dart';
import 'form_row_modal.dart';
import 'form_table.dart';

class InvAdjustmentInFormBody extends StatefulWidget {
  const InvAdjustmentInFormBody({Key? key}) : super(key: key);

  @override
  State<InvAdjustmentInFormBody> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<InvAdjustmentInFormBody> {
  final TextEditingController _remarksController = TextEditingController();
  final TextEditingController _postingDateController = TextEditingController();
  late List<String?> currUserBranches;
  String? selectedBranch;

  @override
  void initState() {
    currUserBranches = context.read<SystemUserBranchRepo>().currentUserBranch();
    _postingDateController.text = DateTime.now().toString();
    context
        .read<InvAdjustmentInFormBloc>()
        .add(TransdateChanged(_postingDateController.text));
    super.initState();
  }

  @override
  void dispose() {
    _remarksController.dispose();
    _postingDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              // width: Responsive.isDesktop(context)
              //     ? constraints.maxWidth * .5
              //     : constraints.maxWidth,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flex(
                    mainAxisSize: MainAxisSize.min,
                    direction: Responsive.isMobile(context)
                        ? Axis.vertical
                        : Axis.horizontal,
                    children: [
                      Flexible(
                        child: InfoLabel(
                          label: "Branch",
                          child: ComboBox<String>(
                            placeholder: const Text('Selected list item'),
                            isExpanded: true,
                            items: currUserBranches
                                .map((e) => ComboBoxItem<String>(
                                      value: e,
                                      child: Text(e ?? ""),
                                    ))
                                .toList(),
                            value: selectedBranch,
                            onChanged: (value) {
                              if (value != null) {
                                setState(() => selectedBranch = value);
                                context
                                    .read<InvAdjustmentInFormBloc>()
                                    .add(BranchChanged(value));
                              }
                            },
                          ),
                        ),
                      ),
                      Responsive.isMobile(context)
                          ? Constant.heightSpacer
                          : Constant.widthSpacer,
                      Flexible(
                        child: m.Material(
                          child: DateTimePicker(
                            enabled: false,
                            type: DateTimePickerType.date,
                            dateMask: 'MM/dd/yyyy',
                            controller: _postingDateController,
                            firstDate: DateTime(2021),
                            lastDate: DateTime(2100),
                            icon: const Icon(FluentIcons.event),
                            dateLabelText: 'Posting Date',
                            use24HourFormat: false,
                            locale: const Locale('en', 'US'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Constant.heightSpacer,
                  Flexible(
                    child: TextFormBox(
                      header: "Remarks",
                      controller: _remarksController,
                      minLines: 2,
                      maxLines: 4,
                      onChanged: (_) {
                        context
                            .read<InvAdjustmentInFormBloc>()
                            .add(RemarksChanged(_remarksController));
                      },
                    ),
                  ),
                  Constant.heightSpacer,
                  Flexible(
                    child: CustomButton(
                      onPressed: (selectedBranch ?? "").isEmpty
                          ? null
                          : () {
                              showDialog(
                                context: context,
                                useRootNavigator: false,
                                builder: (_) => FormRowModal(
                                  invAdjInBloc:
                                      context.read<InvAdjustmentInFormBloc>(),
                                ),
                              );
                            },
                      child: const Text("Insert Row"),
                    ),
                  ),
                ],
              ),
            ),
            Constant.heightSpacer,
            const Expanded(child: InvAdjustmentInRowsFormTable()),
            Constant.heightSpacer,
            SizedBox(
              width: 100,
              height: 30,
              child: CustomFilledButton(
                onPressed: context
                        .watch<InvAdjustmentInFormBloc>()
                        .state
                        .status
                        .isValidated
                    ? () {
                        CustomDialogBox.warningMessage(
                          context,
                          message: "Are you sure you want to proceed?",
                          onPositiveClick: (cntx) {
                            context
                                .read<InvAdjustmentInFormBloc>()
                                .add(NewInvAdjustmentInSubmitted());
                          },
                        );
                      }
                    : null,
                child: const Center(
                  child: Text(
                    "Submit",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      letterSpacing: .5,
                    ),
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }
}
