import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:line_icons/line_icons.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_app/src/screens/widgets/custom_text_field.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../utils/constant.dart';

import '../../../../widgets/custom_dropdown_search.dart';
import '../bloc/bloc.dart';

class CustomerSelectionScreen extends StatelessWidget {
  const CustomerSelectionScreen({Key? key}) : super(key: key);
  static const String routeName = "CustomerSelectionRoute";

  @override
  Widget build(BuildContext context) {
    return const Body();
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late CreatePriceQuotationBloc bloc;

  TextEditingController customerCodeController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  String? branchCode;
  CustomerModel? selectedCustomer;

  late List<String> _branchesCode = [];
  final ValueNotifier<List<CustomerModel>> _customers = ValueNotifier([]);

  @override
  void initState() {
    _branchesCode = context.read<SystemUserBranchRepo>().currentUserBranch();
    bloc = context.read<CreatePriceQuotationBloc>();

    super.initState();
  }

  @override
  void dispose() {
    customerCodeController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    contactNumberController.dispose();
    addressController.dispose();
    super.dispose();
  }

  void onSelectedCustomerChanged() {
    CustomerAddressModel? address;
    if (selectedCustomer != null) {
      address = selectedCustomer?.addresses.firstWhere((e) => e!.isDefault);
    }
    customerCodeController.text = selectedCustomer?.code ?? "";
    firstNameController.text = selectedCustomer?.firstName ?? "";
    lastNameController.text = selectedCustomer?.lastName ?? "";
    contactNumberController.text = selectedCustomer?.contactNumber ?? "";
    addressController.text = """${address?.streetAddress ?? ''}
${address?.brgy == null ? '' : 'Brgy. ${address?.brgy}'}
${address?.cityMunicipality ?? ''}, ${address?.province ?? ''}
""";

    bloc.add(AddressChanged(addressController.text));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreatePriceQuotationBloc, CreateSalesOrderState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Customer Selection",
                style: Theme.of(context).textTheme.headline6,
              ),
              Constant.heightSpacer,
              _branchSelectionField(context),
              Constant.heightSpacer,
              _customerSelectionField(state),
              Constant.heightSpacer,
              _firstNameField(),
              Constant.heightSpacer,
              _lastNameField(),
              Constant.heightSpacer,
              _contactNumberField(),
              Constant.heightSpacer,
              customerAddressField(),
            ],
          ),
        );
      },
    );
  }

  CustomTextField _contactNumberField() {
    return CustomTextField(
      labelText: "Contact Number",
      controller: contactNumberController,
      prefixIcon: const Icon(LineIcons.phone),
    );
  }

  CustomTextField _lastNameField() {
    return CustomTextField(
      labelText: "Last Name",
      controller: lastNameController,
      prefixIcon: const Icon(Icons.person),
      enabled: false,
    );
  }

  CustomTextField _firstNameField() {
    return CustomTextField(
      labelText: "First Name",
      controller: firstNameController,
      prefixIcon: const Icon(Icons.person),
      enabled: false,
    );
  }

  ValueListenableBuilder<List<CustomerModel>> _customerSelectionField(
      CreateSalesOrderState state) {
    return ValueListenableBuilder<List<CustomerModel>>(
        valueListenable: _customers,
        builder: (context, customers, _) {
          return MyCustomDropdownSearch<CustomerModel>(
            enable: state.dispatchingBranch.valid,
            labelText: "Select Customer Code",
            selectedItem: selectedCustomer,
            itemAsString: (data) => data!.code,
            items: customers,
            compareFn: (data, selectedData) => data == selectedCustomer,
            itemBuilder: (context, data, _) => Card(
              elevation: 2,
              child: ListTile(
                selected: data.code == state.customerCode.value,
                title: Text("Customer Code: ${data.code}"),
              ),
            ),
            onChanged: (CustomerModel? data) {
              setState(() {
                selectedCustomer = data;
                onSelectedCustomerChanged();
              });
              context
                  .read<CreatePriceQuotationBloc>()
                  .add(CustomerChanged(data));
            },
          );
        });
  }

  MyCustomDropdownSearch<String> _branchSelectionField(BuildContext context) {
    return MyCustomDropdownSearch<String>(
      labelText: "Select Branch",
      selectedItem: branchCode,
      itemAsString: (data) => data!,
      items: _branchesCode,
      compareFn: (data, selectedData) => data == selectedData,
      onChanged: (String? data) async {
        bloc.add(ClearSalesOrder());

        setState(() {
          selectedCustomer = null;
          onSelectedCustomerChanged();
        });

        bloc.add(BranchCodeChanged(data ?? ""));
        if (data != null && data.isNotEmpty) {
          context.loaderOverlay.show();
          _customers.value =
              await context.read<CustomerRepo>().getCustomerByLocation(
            branchCode: data,
            params: {"is_active": true, "is_approved": true},
          );
          context.loaderOverlay.hide();
        }
      },
    );
  }

  customerAddressField() {
    return BlocBuilder<CreatePriceQuotationBloc, CreateSalesOrderState>(
      builder: (_, state) {
        return TextFormField(
          keyboardType: TextInputType.multiline,
          controller: addressController,
          readOnly: true,
          onTap: state.customerCode.valid
              ? () {
                  getCustomerAddress(
                    selectedCustomer!.addresses,
                  );
                }
              : null,
          minLines: 3,
          maxLines: 6,
          decoration: customInputDecoration(
            labelText: 'Delivery Address',
            prefixIcon: const Icon(LineIcons.home),
            suffixIcon: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () {
                addressController.clear();
                context
                    .read<CreatePriceQuotationBloc>()
                    .add(AddressChanged(addressController.text));
              },
            ),
          ),
        );
      },
    );
  }

  getCustomerAddress(
    List<CustomerAddressModel?> addresses,
  ) {
    showMaterialModalBottomSheet(
      context: context,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
      ),
      builder: (_) {
        return SizedBox(
          height: (MediaQuery.of(context).size.height * .5),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.separated(
                itemBuilder: (_, index) {
                  return Card(
                    child: InkWell(
                      onTap: () {
                        String completeAddress =
                            """${addresses[index]?.streetAddress ?? ''}
${addresses[index]?.brgy == null ? '' : 'Brgy. ${addresses[index]?.brgy}'}
${addresses[index]?.cityMunicipality ?? ''}, ${addresses[index]?.province ?? ''}
""";
                        addressController.text = completeAddress;
                        context
                            .read<CreatePriceQuotationBloc>()
                            .add(AddressChanged(addressController.text));
                        context.router.pop();
                      },
                      child: SizedBox(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Wrap(
                                children: [
                                  const Text(
                                    'Street Address: ',
                                  ),
                                  Text(addresses[index]?.streetAddress ?? ''),
                                ],
                              ),
                              Wrap(
                                children: [
                                  const Text(
                                    'Barangay: ',
                                  ),
                                  Text(addresses[index]?.brgy ?? ''),
                                ],
                              ),
                              Wrap(
                                children: [
                                  const Text(
                                    'City / Municipality: ',
                                  ),
                                  Text(
                                      addresses[index]?.cityMunicipality ?? ''),
                                ],
                              ),
                              Wrap(
                                children: [
                                  const Text(
                                    'Province: ',
                                  ),
                                  Text(addresses[index]?.province ?? ''),
                                ],
                              ),
                              Wrap(
                                children: [
                                  const Text(
                                    'Other details: ',
                                  ),
                                  Text(addresses[index]?.otherDetails ?? ''),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return const Divider(
                    thickness: 1,
                    color: Color(0xFFBDBDBD),
                  );
                },
                itemCount: addresses.length),
          ),
        );
      },
    );
  }
}

customInputDecoration({
  required String labelText,
  Widget? suffix,
  Widget? prefix,
  Widget? prefixIcon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.transparent, width: 0),
    ),
    filled: true,
    fillColor: const Color(0xFFeeeee4),
    labelText: labelText,
    prefix: prefix,
    suffix: suffix,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
  );
}
