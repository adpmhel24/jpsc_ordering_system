import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../global_bloc/bloc_customer/create_customer/bloc.dart';
import '../../../../../router/router.gr.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/custom_animated_dialog.dart';
import '../../../../widgets/custom_dropdown_search.dart';
import '../../../../widgets/custom_text_field.dart';

class CreateCustomerScreen extends StatefulWidget {
  const CreateCustomerScreen({Key? key}) : super(key: key);

  @override
  State<CreateCustomerScreen> createState() => _CreateCustomerScreenState();
}

class _CreateCustomerScreenState extends State<CreateCustomerScreen> {
  @override
  Widget build(BuildContext buildContext) {
    return BlocProvider(
      create: (_) => CreateCustomerBloc(buildContext.read<CustomerRepo>()),
      child: BlocListener<CreateCustomerBloc, CreateCustomerState>(
        listener: (context, state) {
          if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            CustomAnimatedDialog.error(context, message: state.message);
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            context.router.replace(
              SuccessScreenRoute(
                message: state.message,
                buttonLabel: "Go Back To Menu",
                onButtonPressed: (cntx) {
                  cntx.router.replace(
                    const MainScreenRoute(
                      children: [
                        CreateCustomerScreenRoute(),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
        child: Builder(builder: (context) {
          return Scaffold(
            body: const CreateCustomerBody(),
            bottomNavigationBar:
                BlocBuilder<CreateCustomerBloc, CreateCustomerState>(
              builder: (context, state) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: ElevatedButton(
                  onPressed: state.status.isValidated
                      ? () {
                          CustomAnimatedDialog.warning(
                            context,
                            message: "Are you sure you want to proceed?",
                            onPositiveClick: (cntx) {
                              context
                                  .read<CreateCustomerBloc>()
                                  .add(NewCustomerSubmitted());
                            },
                          );
                        }
                      : null,
                  child: const Text("Add Customer"),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class CreateCustomerBody extends StatefulWidget {
  const CreateCustomerBody({Key? key}) : super(key: key);

  @override
  State<CreateCustomerBody> createState() => _CreateCustomerBodyState();
}

class _CreateCustomerBodyState extends State<CreateCustomerBody> {
  final TextEditingController _codeController = TextEditingController();
  final TextEditingController _cardNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _contactNumberController =
      TextEditingController();
  final TextEditingController _creditLimitController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  BranchModel? selectedBranch;
  PaymentTermsModel? selectedPaymentTerm;

  @override
  void dispose() {
    _codeController.dispose();
    _cardNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _contactNumberController.dispose();
    _emailController.dispose();
    _creditLimitController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var createCustomerBloc = context.watch<CreateCustomerBloc>();

    return Padding(
      padding: const EdgeInsets.only(top: 15, right: 10, left: 10, bottom: 10),
      child: ListView(
        children: [
          Text(
            "Create Customer",
            style: Theme.of(context).textTheme.headline6,
          ),
          Constant.heightSpacer,
          _customerCodeField(createCustomerBloc),
          Constant.heightSpacer,
          _customerCardNameField(createCustomerBloc),
          Constant.heightSpacer,
          _firstNameField(createCustomerBloc),
          Constant.heightSpacer,
          _lastNameField(createCustomerBloc),
          Constant.heightSpacer,
          _groupLocationField(context, createCustomerBloc),
          Constant.heightSpacer,
          _paymentTermField(context, createCustomerBloc),
          Constant.heightSpacer,
          _contactNumberField(createCustomerBloc),
          Constant.heightSpacer,
          _emailAddressField(createCustomerBloc),
          Constant.heightSpacer,
          _creditLimitField(createCustomerBloc),
          Constant.heightSpacer,
          TextButton(
            onPressed: () {
              context.router.push(AddressFormScreenRoute(
                  createCustomerBloc: context.read<CreateCustomerBloc>()));
            },
            child: const Text("Insert Address"),
          ),
          ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: createCustomerBloc.state.addresses.value.length,
              itemBuilder: (_, index) {
                Map<String, dynamic> stateAddress =
                    createCustomerBloc.state.addresses.value[index];
                return Dismissible(
                  key: Key(stateAddress.toString()),
                  background: Container(
                    alignment: Alignment.centerRight,
                    color: Colors.red,
                    child: const Icon(Icons.delete),
                  ),
                  direction: DismissDirection.endToStart,
                  onDismissed: (direction) {
                    createCustomerBloc.add(CustAddressRemoved(index));
                  },
                  child: SizedBox(
                    width: double.infinity,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Street: ${stateAddress['street_address']}"),
                              Text("Brgy: ${stateAddress['brgy']}"),
                              Text(
                                  "City/Municpality: ${stateAddress['city_municipality']}"),
                              Text("Province: ${stateAddress['province']}"),
                              Text("Others: ${stateAddress['other_details']}"),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text("Is Default :"),
                                  Icon(stateAddress['is_default']
                                      ? Icons.check
                                      : null),
                                ],
                              ),
                            ]),
                      ),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  CustomTextField _emailAddressField(CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      controller: _emailController,
      labelText: "Email Address",
      keyboardType: TextInputType.emailAddress,
      prefixIcon: const Icon(Icons.email),
      onChanged: (_) {
        createCustomerBloc.add(CustEmailChanged(_emailController.text));
      },
      validator: (_) => createCustomerBloc.state.custEmail.invalid
          ? "Invalid email address"
          : null,
    );
  }

  CustomTextField _contactNumberField(CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      controller: _contactNumberController,
      keyboardType: TextInputType.phone,
      labelText: "Contact Number",
      prefixIcon: const Icon(Icons.phone_android),
      onChanged: (v) => createCustomerBloc.add(
        CustContactNumberChanged(v.trim()),
      ),
    );
  }

  CustomTextField _creditLimitField(CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      controller: _creditLimitController,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      inputFormatters: <TextInputFormatter>[
        FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
      ],
      labelText: "Credit Limit",
      prefixIcon: const Icon(Icons.money_sharp),
      onChanged: (value) => createCustomerBloc.add(
        CustCreditLimitChanged(
          double.parse(value.isEmpty ? "0" : value),
        ),
      ),
    );
  }

  CustomTextField _lastNameField(CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      controller: _lastNameController,
      labelText: "Customer Last Name",
      prefixIcon: const Icon(Icons.person),
      onChanged: (v) {
        createCustomerBloc.add(CustLastNameChanged(v.trim()));
      },
    );
  }

  CustomTextField _firstNameField(CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      controller: _firstNameController,
      labelText: "Customer First Name",
      prefixIcon: const Icon(Icons.person),
      onChanged: (v) {
        createCustomerBloc.add(CustFirstNameChanged(v.trim()));
      },
    );
  }

  CustomTextField _customerCodeField(CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      autovalidateMode: AutovalidateMode.always,
      controller: _codeController,
      labelText: "Card Code *",
      prefixIcon: const Icon(Icons.person),
      prefix: const Text("C_"),
      maxLength: 15,
      onChanged: (v) {
        createCustomerBloc.add(CustCodeChanged(v.trim()));
      },
      validator: (_) =>
          createCustomerBloc.state.custCode.invalid ? "Requierd field" : null,
    );
  }

  CustomTextField _customerCardNameField(
      CreateCustomerBloc createCustomerBloc) {
    return CustomTextField(
      controller: _cardNameController,
      labelText: "Card Name",
      maxLength: 100,
      prefixIcon: const Icon(Icons.person),
      onChanged: (v) {
        createCustomerBloc.add(CardNameChanged(v.trim()));
      },
    );
  }

  MyCustomDropdownSearch<PaymentTermsModel> _paymentTermField(
      BuildContext context, CreateCustomerBloc createCustomerBloc) {
    return MyCustomDropdownSearch<PaymentTermsModel>(
      autoValidateMode: AutovalidateMode.always,
      labelText: "Payment Term",
      selectedItem: selectedPaymentTerm,
      itemAsString: (data) => data!.code,
      prefixIcon: const Icon(Icons.payment),
      onFind: (value) =>
          context.read<PaymentTermRepo>().offlineSearch(value ?? ""),
      compareFn: (data, selectedData) => data == selectedData,
      itemBuilder: (context, data, selected) => Card(
        elevation: 2,
        child: ListTile(
          selected: selected,
          title: Text("Code: ${data.code}"),
          subtitle: Text("Description: ${data.description}"),
        ),
      ),
      onChanged: (PaymentTermsModel? data) {
        selectedPaymentTerm = data;
        createCustomerBloc.add(CustPaymentTermChanged(data?.code ?? ""));
      },
      validator: (_) => createCustomerBloc.state.custPaymentTerm.invalid
          ? "Require field."
          : null,
    );
  }

  MyCustomDropdownSearch<BranchModel> _groupLocationField(
      BuildContext context, CreateCustomerBloc createCustomerBloc) {
    return MyCustomDropdownSearch<BranchModel>(
      autoValidateMode: AutovalidateMode.always,
      labelText: "Group Location *",
      selectedItem: selectedBranch,
      itemAsString: (data) => data!.code,
      prefixIcon: const Icon(Icons.location_on),
      onFind: (value) => context.read<BranchRepo>().offlineSearch(value ?? ""),
      compareFn: (data, selectedData) => data == selectedData,
      itemBuilder: (context, data, selected) => Card(
        elevation: 2,
        child: ListTile(
          selected: selected,
          title: Text("Branch Code: ${data.code}"),
          subtitle: Text("Description: ${data.description}"),
        ),
      ),
      onChanged: (BranchModel? data) {
        selectedBranch = data;

        createCustomerBloc.add(CustBranchChanged(data?.code ?? ""));
      },
      validator: (_) =>
          createCustomerBloc.state.custBranch.invalid ? "Require field." : null,
    );
  }
}
