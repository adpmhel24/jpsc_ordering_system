import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mobile_app/src/screens/widgets/custom_text_field.dart';

import '../../../../../data/models/models.dart';
import '../../../../../data/repositories/repos.dart';
import '../../../../../global_bloc/bloc_customer/create_customer/bloc.dart';
import '../../../../utils/constant.dart';
import '../../../../widgets/custom_dropdown_search.dart';

class AddressFormScreen extends StatefulWidget {
  const AddressFormScreen({Key? key, required this.createCustomerBloc})
      : super(key: key);

  final CreateCustomerBloc createCustomerBloc;

  @override
  State<AddressFormScreen> createState() => _AddressFormScreenState();
}

class _AddressFormScreenState extends State<AddressFormScreen> {
  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();
  ProvinceModel? selectedProvince;
  CityMunicipalityModel? selectedMunicipality;
  BrgyModel? selectedBrgy;

  final ValueNotifier<String> _street = ValueNotifier("");

  bool isDefault = false;

  @override
  void dispose() {
    _street.dispose();
    _streetController.dispose();
    _otherDetailsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Customer Address Form"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _provinceField(context),
              Constant.heightSpacer,
              _municipalityField(context),
              Constant.heightSpacer,
              _brgyField(context),
              Constant.heightSpacer,
              CustomTextField(
                labelText: "Street address",
                controller: _streetController,
                minLines: 3,
                maxLines: 6,
                prefixIcon: const Icon(Icons.location_on),
                onChanged: (value) => _street.value = value,
              ),
              Constant.heightSpacer,
              CustomTextField(
                labelText: "Other Details",
                controller: _otherDetailsController,
                minLines: 3,
                maxLines: 6,
                prefixIcon: const Icon(Icons.location_on),
              ),
              Constant.heightSpacer,
              CheckboxListTile(
                title: const Text("isDefault"),
                value: isDefault,
                onChanged: (value) => setState(
                  () {
                    isDefault = value!;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: ValueListenableBuilder<String>(
        valueListenable: _street,
        builder: (context, value, _) {
          return Padding(
            padding: const EdgeInsets.all(10.0),
            child: ElevatedButton(
              onPressed: value.isEmpty
                  ? null
                  : () {
                      widget.createCustomerBloc.add(CustAddressAdded({
                        "province": selectedProvince?.name ?? "",
                        "city_municipality": selectedMunicipality?.name ?? "",
                        "brgy": selectedBrgy?.name ?? "",
                        "other_details": _otherDetailsController.text,
                        "street_address": _street.value,
                        "is_default": true,
                      }));
                      context.router.pop();
                    },
              child: const Text("Add"),
            ),
          );
        },
      ),
    );
  }

  MyCustomDropdownSearch<ProvinceModel> _provinceField(
    BuildContext context,
  ) {
    return MyCustomDropdownSearch<ProvinceModel>(
      autoValidateMode: AutovalidateMode.always,
      labelText: "Province",
      selectedItem: selectedProvince,
      itemAsString: (data) => data!.name!,
      prefixIcon: const Icon(Icons.location_city),
      onFind: (value) =>
          context.read<PhLocationRepo>().searchProvinceByKeyword(value ?? ""),
      compareFn: (data, selectedData) => data == selectedData,
      itemBuilder: (context, data, selected) => Card(
        elevation: 2,
        child: ListTile(
          selected: selected,
          title: Text("${data.name}"),
        ),
      ),
      onChanged: (ProvinceModel? data) {
        selectedProvince = data;
      },
    );
  }

  MyCustomDropdownSearch<CityMunicipalityModel> _municipalityField(
    BuildContext context,
  ) {
    return MyCustomDropdownSearch<CityMunicipalityModel>(
      autoValidateMode: AutovalidateMode.always,
      labelText: "City/Municipality",
      selectedItem: selectedMunicipality,
      itemAsString: (data) => data!.name,
      prefixIcon: const Icon(Icons.location_city_rounded),
      onFind: (value) => context
          .read<PhLocationRepo>()
          .searchCityMunicipalityByKeyword(selectedProvince, value ?? ""),
      compareFn: (data, selectedData) => data == selectedData,
      itemBuilder: (context, data, selected) => Card(
        elevation: 2,
        child: ListTile(
          selected: selected,
          title: Text(data.name),
        ),
      ),
      onChanged: (CityMunicipalityModel? data) {
        selectedMunicipality = data;
      },
    );
  }

  MyCustomDropdownSearch<BrgyModel> _brgyField(
    BuildContext context,
  ) {
    return MyCustomDropdownSearch<BrgyModel>(
      autoValidateMode: AutovalidateMode.always,
      labelText: "Brgy  ",
      selectedItem: selectedBrgy,
      itemAsString: (data) => data!.name,
      prefixIcon: const Icon(Icons.location_city_rounded),
      onFind: (value) =>
          context.read<PhLocationRepo>().searchBarangaysByKeyword(
                selectedProvince: selectedProvince,
                selectedCityMunicapality: selectedMunicipality,
                keyword: value ?? "",
              ),
      compareFn: (data, selectedData) => data == selectedData,
      itemBuilder: (context, data, selected) => Card(
        elevation: 2,
        child: ListTile(
          selected: selected,
          title: Text(data.name),
        ),
      ),
      onChanged: (BrgyModel? data) {
        selectedBrgy = data;
      },
    );
  }
}
