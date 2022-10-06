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
  final ValueNotifier<List<PaymentTermModel>> _paymentTerms = ValueNotifier([]);
  final ValueNotifier<List<BranchModel>> _branches = ValueNotifier([]);

  final double _kTextBoxWidth = 200.0;

  @override
  void initState() {
    bloc = context.read<CreateUpdateCustomerBloc>();
    fetInitialData();
    _codeController.text = widget.selectedCustomer?.code ?? "";
    _firstNameController.text = widget.selectedCustomer?.firstName ?? "";
    _lastNameController.text = widget.selectedCustomer?.lastName ?? "";
    _contactNumberController.text =
        widget.selectedCustomer?.contactNumber ?? "";
    _emailController.text = widget.selectedCustomer?.email ?? "";
    _creditLimitController.text = widget.selectedCustomer != null
        ? widget.selectedCustomer!.creditLimit.toStringAsFixed(2)
        : "0";
    selectedBranch = widget.selectedCustomer?.location ?? "";
    selectedPaymentTerm = widget.selectedCustomer?.paymentTerm ?? "";

    isApprove = ValueNotifier(widget.selectedCustomer?.isApproved ?? false);
    isActive = ValueNotifier(widget.selectedCustomer?.isActive ?? false);
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _creditLimitController.dispose();
    _paymentTerms.dispose();
    _branches.dispose();
    isApprove.dispose();
    isActive.dispose();
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
                firstNameField(),
                lastNameField(),
                contactNumberField(),
                emailAddressField(),
                creditLimitField(),
                termField(),
                custLocationField(),
                if (widget.selectedCustomer != null) _isActiveSwitch(),
                if (widget.selectedCustomer != null) _isApproveSwitch(),
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
                        cntx.router.pop();
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
        label: "Payment Term",
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
          bloc.add(CustCreditLimitChanged(double.parse(value)));
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
          bloc.add(CustEmailChanged(value));
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
          bloc.add(CustContactNumberChanged(value));
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
          bloc.add(CustLastNameChanged(value));
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
          bloc.add(CustFirstNameChanged(value));
        },
      ),
    );
  }

  SizedBox customerCodeField() {
    return SizedBox(
      width: _kTextBoxWidth,
      child: TextFormBox(
        header: "Customer Code",
        autovalidateMode: AutovalidateMode.always,
        controller: _codeController,
        prefix: const Icon(FluentIcons.user_followed),
        onChanged: (value) {
          bloc.add(CustCodeChanged(value));
        },
        validator: (_) =>
            bloc.state.custCode.invalid ? "Required field!" : null,
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
          content: Text(value ? 'Approved' : 'For Approve'),
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
          content: Text(value ? 'Active' : 'Inactive'),
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
          placeholder: const Text('Payment Term *'),
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
          validator: (_) =>
              bloc.state.custPaymentTerm.invalid ? "Required field" : null,
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
