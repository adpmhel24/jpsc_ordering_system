part of 'customer_form.dart';

class CustomerFormBody extends StatefulWidget {
  const CustomerFormBody({Key? key}) : super(key: key);

  @override
  State<CustomerFormBody> createState() => _CustomerFormBodyState();
}

class _CustomerFormBodyState extends State<CustomerFormBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  BranchModel? selectedBranch;
  PaymentTermModel? selectedPaymentTerm;
  final ValueNotifier<List<PaymentTermModel>> _paymentTerms = ValueNotifier([]);
  final ValueNotifier<List<BranchModel>> _branches = ValueNotifier([]);

  final double _kTextBoxWidth = 250.0;

  @override
  void initState() {
    fetchPaymentTerm();
    fetchBranches();
    super.initState();
  }

  @override
  void dispose() {
    _codeController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _paymentTerms.dispose();
    _branches.dispose();

    super.dispose();
  }

  void fetchPaymentTerm() async {
    final repo = context.read<PaymentTermRepo>();
    await repo.getAll();
    _paymentTerms.value = repo.datas;
  }

  void fetchBranches() async {
    final repo = context.read<BranchRepo>();
    await repo.getAll();
    _branches.value = repo.datas;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SingleChildScrollView(
          child: Wrap(
            spacing: 20,
            runSpacing: Constant.minPadding,
            children: [
              SizedBox(
                width: _kTextBoxWidth,
                child: TextFormBox(
                  header: "Customer Code",
                  autovalidateMode: AutovalidateMode.always,
                  controller: _codeController,
                  prefix: const Icon(FluentIcons.user_followed),
                ),
              ),
              SizedBox(
                width: _kTextBoxWidth,
                child: TextFormBox(
                  header: "First Name",
                  controller: _firstNameController,
                  prefix: const Icon(FluentIcons.user_window),
                ),
              ),
              SizedBox(
                width: _kTextBoxWidth,
                child: TextFormBox(
                  header: "Last Name",
                  controller: _lastNameController,
                  prefix: const Icon(FluentIcons.account_management),
                ),
              ),
              SizedBox(
                width: _kTextBoxWidth,
                child: TextFormBox(
                  header: "Contact Number",
                  controller: _contactNumberController,
                  keyboardType: TextInputType.phone,
                  prefix: const Icon(FluentIcons.phone),
                ),
              ),
              SizedBox(
                width: _kTextBoxWidth,
                child: TextFormBox(
                  header: "Email Address",
                  autovalidateMode: AutovalidateMode.always,
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  prefix: const Icon(FluentIcons.edit_mail),
                ),
              ),
              SizedBox(
                width: _kTextBoxWidth,
                child:
                    InfoLabel(label: "Payment Term", child: paymentTermField()),
              ),
              SizedBox(
                width: _kTextBoxWidth,
                child: InfoLabel(
                  label: "Location",
                  child: locationField(),
                ),
              ),
            ],
          ),
        ),
        Expanded(child: SizedBox.expand()),
      ],
    );
  }

  ValueListenableBuilder<List<PaymentTermModel>> paymentTermField() {
    return ValueListenableBuilder<List<PaymentTermModel>>(
      valueListenable: _paymentTerms,
      builder: (context, data, wt) {
        return ComboboxFormField<String>(
          autovalidateMode: AutovalidateMode.always,
          placeholder: const Text('Select Payment Term'),
          isExpanded: true,
          items: data
              .map(
                (e) => ComboBoxItem<String>(
                  value: e.code,
                  child: Text(e.code),
                ),
              )
              .toList(),
          onChanged: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide a value';
            }
            return null;
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
          items: data
              .map(
                (e) => ComboBoxItem<String>(
                  value: e.code,
                  child: Text(e.code),
                ),
              )
              .toList(),
          onChanged: (value) {},
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please provide a value';
            }
            return null;
          },
        );
      },
    );
  }
}
