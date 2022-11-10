part of 'customer_form.dart';

class CustomerFormBody extends StatefulWidget {
  const CustomerFormBody({
    Key? key,
    this.selectedCustomer,
  }) : super(key: key);

  final CustomerModel? selectedCustomer;

  @override
  State<CustomerFormBody> createState() => _CustomerFormBodyState();
}

class _CustomerFormBodyState extends State<CustomerFormBody> {
  late CreateUpdateCustomerBloc bloc;
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();

  String? selectedBranch;
  String? selectedPaymentTerm;
  late ValueNotifier<bool> isApprove;
  late ValueNotifier<bool> isActive;
  late ValueNotifier<bool> withSap;
  final ValueNotifier<List<PaymentTermModel>> _paymentTerms = ValueNotifier([]);
  final ValueNotifier<List<BranchModel>> _branches = ValueNotifier([]);

  final double _kTextBoxWidth = 200.0;

  @override
  void initState() {
    bloc = context.read<CreateUpdateCustomerBloc>();
    fetInitialData();
    _codeController.text = widget.selectedCustomer?.code ?? "";
    _cardNameController.text = widget.selectedCustomer?.cardName ?? "";
    _firstNameController.text = widget.selectedCustomer?.firstName ?? "";
    _lastNameController.text = widget.selectedCustomer?.lastName ?? "";
    _contactNumberController.text =
        widget.selectedCustomer?.contactNumber ?? "";
    _emailController.text = widget.selectedCustomer?.email ?? "";
    _creditLimitController.text = widget.selectedCustomer != null
        ? widget.selectedCustomer!.creditLimit!.toStringAsFixed(2)
        : "0";
    selectedBranch = widget.selectedCustomer?.location ?? "";
    selectedPaymentTerm = widget.selectedCustomer?.paymentTerm ?? "";

    isApprove = ValueNotifier(widget.selectedCustomer?.isApproved ?? false);
    isActive = ValueNotifier(widget.selectedCustomer?.isActive ?? false);
    withSap = ValueNotifier(widget.selectedCustomer?.withSap ?? false);

    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _cardNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _creditLimitController.dispose();
    _paymentTerms.dispose();
    _branches.dispose();
    isApprove.dispose();
    isActive.dispose();
    withSap.dispose();
    super.dispose();
  }

  void fetInitialData() async {
    context.loaderOverlay.show();

    final termRepo = context.read<PaymentTermRepo>();
    final branchRepo = context.read<BranchRepo>();
    await termRepo.getAll();
    await branchRepo.getAll();
    _paymentTerms.value = termRepo.datas;
    _branches.value = branchRepo.datas;

    context.loaderOverlay.hide();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 200,
          child: SingleChildScrollView(
            child: Wrap(
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 8,
              runSpacing: 12,
              children: [
                customerCodeField(),
                cardNameField(),
                firstNameField(),
                lastNameField(),
                contactNumberField(),
                emailAddressField(),
                creditLimitField(),
                termField(),
                custLocationField(),
                if (widget.selectedCustomer != null) _isActiveSwitch(),
                if (widget.selectedCustomer != null) _isApproveSwitch(),
                if (widget.selectedCustomer != null) _withSapSwitch(),
              ],
            ),
          ),
        ),
        Constant.heightSpacer,
        Align(
          alignment: Alignment.centerLeft,
          child: Button(
              child: const Text("Add Address"),
              onPressed: () {
                showDialog(
                  context: context,
                  useRootNavigator: false,
                  builder: (_) => CustomerAddressFormModal(
                    bloc: bloc,
                  ),
                );
              }),
        ),
        Constant.heightSpacer,
        BlocBuilder<CreateUpdateCustomerBloc, CreateUpdateCustomerState>(
          builder: (context, state) {
            return Expanded(
              child: CustomerFormAddressTable(
                addresses:
                    state.addresses.value.where((e) => !e.isRemove).toList(),
              ),
            );
          },
        ),
        Constant.heightSpacer,
        Align(
          alignment: Alignment.centerLeft,
          child: Button(
            onPressed: context
                    .watch<CreateUpdateCustomerBloc>()
                    .state
                    .status
                    .isValidated
                ? () {
                    CustomDialogBox.warningMessage(
                      context,
                      message: "Are you sure you want to submit?",
                      onPositiveClick: (cntx) {
                        if (widget.selectedCustomer != null) {
                          bloc.add(UpdateCustomerSubmitted());
                        } else {
                          bloc.add(NewCustomerSubmitted());
                        }
                      },
                    );
                  }
                : null,
            child: Text(widget.selectedCustomer != null ? "Update" : "Add"),
          ),
        ),
      ],
    );
  }

  SizedBox custLocationField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: InfoLabel(
        label: "Location",
        child: locationField(),
      ),
    );
  }

  SizedBox termField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: InfoLabel(
        label: "Payment Terms",
        child: paymentTermField(),
      ),
    );
  }

  SizedBox creditLimitField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Credit Limit",
        controller: _creditLimitController,
        keyboardType: const TextInputType.numberWithOptions(decimal: true),
        prefix: const Icon(FluentIcons.money),
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            value = "0";
          }
          bloc.add(CustCreditLimitChanged(double.parse(value.trim())));
        },
      ),
    );
  }

  SizedBox emailAddressField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Email Address",
        autovalidateMode: AutovalidateMode.always,
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        prefix: const Icon(FluentIcons.edit_mail),
        onChanged: (value) {
          bloc.add(CustEmailChanged(value.trim()));
        },
        validator: (_) =>
            bloc.state.custEmail.invalid ? "Invalid email address" : null,
      ),
    );
  }

  SizedBox contactNumberField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Contact Number",
        controller: _contactNumberController,
        keyboardType: TextInputType.phone,
        prefix: const Icon(FluentIcons.phone),
        onChanged: (value) {
          bloc.add(CustContactNumberChanged(value.trim()));
        },
      ),
    );
  }

  SizedBox lastNameField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Last Name",
        controller: _lastNameController,
        prefix: const Icon(FluentIcons.account_management),
        onChanged: (value) {
          bloc.add(CustLastNameChanged(value.trim()));
        },
      ),
    );
  }

  SizedBox firstNameField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "First Name",
        controller: _firstNameController,
        prefix: const Icon(FluentIcons.user_window),
        onChanged: (value) {
          bloc.add(CustFirstNameChanged(value.trim()));
        },
      ),
    );
  }

  SizedBox customerCodeField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Card Code *",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        prefix: widget.selectedCustomer != null ? null : const Text("C_"),
        maxLength: 15,
        onChanged: (value) {
          bloc.add(CustCodeChanged(value.trim()));
        },
        validator: (_) =>
            bloc.state.custCode.invalid ? "Required field!" : null,
      ),
    );
  }

  SizedBox cardNameField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Card Name",
        controller: _cardNameController,
        prefix: const Icon(FluentIcons.user_followed),
        maxLength: 100,
        onChanged: (value) {
          bloc.add(CardnameChanged(value.trim()));
        },
      ),
    );
  }

  ValueListenableBuilder<bool> _isApproveSwitch() {
    return ValueListenableBuilder<bool>(
      valueListenable: isApprove,
      builder: (context, value, _) {
        return ToggleSwitch(
          checked: value,
          onChanged: (v) {
            isApprove.value = v;
            bloc.add(CustIsApprovedChanged(v));
          },
          content: Text(value ? 'Approved' : 'Disapproved'),
        );
      },
    );
  }

  ValueListenableBuilder<bool> _withSapSwitch() {
    return ValueListenableBuilder<bool>(
      valueListenable: withSap,
      builder: (context, value, _) {
        return ToggleSwitch(
          checked: value,
          onChanged: (v) {
            withSap.value = v;
            bloc.add(CustWithSapChanged(v));
          },
          content: Text(value ? 'With SAP' : 'Without SAP'),
        );
      },
    );
  }

  ValueListenableBuilder<bool> _isActiveSwitch() {
    return ValueListenableBuilder<bool>(
      valueListenable: isActive,
      builder: (context, value, _) {
        return ToggleSwitch(
          checked: value,
          onChanged: (v) {
            isActive.value = v;
            bloc.add(CustIsActiveChanged(v));
          },
          content: Text(value ? 'Inactive' : 'Active'),
        );
      },
    );
  }

  ValueListenableBuilder<List<PaymentTermModel>> paymentTermField() {
    return ValueListenableBuilder<List<PaymentTermModel>>(
      valueListenable: _paymentTerms,
      builder: (context, data, wt) {
        return ComboboxFormField<String>(
          autovalidateMode: AutovalidateMode.always,
          placeholder: const Text('Payment Terms'),
          isExpanded: true,
          value: selectedPaymentTerm,
          items: data
              .map(
                (e) => ComboBoxItem<String>(
                  value: e.code,
                  child: Text(e.code),
                ),
              )
              .toList(),
          onChanged: (value) {
            bloc.add(CustPaymentTermChanged(value!));
          },
        );
      },
    );
  }

  ValueListenableBuilder<List<BranchModel>> locationField() {
    return ValueListenableBuilder<List<BranchModel>>(
      valueListenable: _branches,
      builder: (context, data, wt) {
        return ComboboxFormField<String>(
          autovalidateMode: AutovalidateMode.always,
          placeholder: const Text('Select Branch'),
          isExpanded: true,
          value: selectedBranch,
          items: data
              .map(
                (e) => ComboBoxItem<String>(
                  value: e.code,
                  child: Text(e.code),
                ),
              )
              .toList(),
          onChanged: (value) {
            bloc.add(CustBranchChanged(value!));
          },
          validator: (value) =>
              bloc.state.custBranch.invalid ? "Required field" : null,
        );
      },
    );
  }
}
