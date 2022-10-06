import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:mobile_app/src/screens/widgets/custom_animated_dialog.dart';
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
  late PhLocationRepo locationRepo;

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _otherDetailsController = TextEditingController();
  ProvinceModel? selectedProvince;
  CityMunicipalityModel? selectedCityMunicipality;
  BrgyModel? selectedBrgy;

  final ValueNotifier<List<ProvinceModel>> _provinces = ValueNotifier([]);
  final ValueNotifier<List<CityMunicipalityModel>> _citiesMunicipalities =
      ValueNotifier([]);
  final ValueNotifier<List<BrgyModel>> _brgys = ValueNotifier([]);
  final ValueNotifier<String> _street = ValueNotifier("");

  bool isDefault = false;

  @override
  void initState() {
    locationRepo = context.read<PhLocationRepo>();
    fetchProvinces();

    super.initState();
  }

  @override
  void dispose() {
    _streetController.dispose();
    _otherDetailsController.dispose();
    _provinces.dispose();
    _citiesMunicipalities.dispose();
    _brgys.dispose();
    _street.dispose();
    super.dispose();
  }

  void fetchProvinces() async {
    context.loaderOverlay.show();
    if (locationRepo.provinces.isEmpty) {
      await locationRepo.fetchProvinces();
    }
    _provinces.value = locationRepo.provinces;
    context.loaderOverlay.hide();
  }

  Future<void> fetchCityMunicipality(ProvinceModel? province) async {
    await locationRepo.fetchCitiesMunicipalities(province);
    _citiesMunicipalities.value = locationRepo.cities;
  }

  Future<void> fetchBrgys(
      ProvinceModel? province, CityMunicipalityModel? city) async {
    await locationRepo.fetchBrgys(
        selectedProvince: province, selectedCityMunicapality: city);
    _brgys.value = locationRepo.brgys;
  }

  String? decodeNCRProvinces(String code) {
    String? provinceName;
    if (code == "133900000") {
      provinceName = "NCR, 1st Dist.(Manila)";
    } else if (code == '137400000') {
      provinceName =
          "NCR, 2nd Dist.(Mandaluyong, Marikina, Pasig, Quezon City, San Juan)";
    } else if (code == '137500000') {
      provinceName = "NCR, 3rd Dist.(Caloocan, Malabon, Navotas, Valenzuela)";
    } else if (code == '137600000') {
      provinceName =
          "NCR, 4th Dist.(LasPiñas, Makati, Muntinlupa, Parañaque, Pasay, Pateros, Taguig)";
    }

    return provinceName;
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
              _provinceField(),
              Constant.heightSpacer,
              _municipalityField(),
              Constant.heightSpacer,
              _brgyField(),
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
                        "city_municipality":
                            selectedCityMunicipality?.name ?? "",
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

  ValueListenableBuilder _provinceField() {
    return ValueListenableBuilder(
        valueListenable: _provinces,
        builder: (context, provinces, _) {
          return MyCustomDropdownSearch<ProvinceModel>(
            autoValidateMode: AutovalidateMode.always,
            labelText: "Province",
            selectedItem: selectedProvince,
            itemAsString: (data) => data!.name!,
            prefixIcon: const Icon(Icons.location_city),
            items: provinces,
            compareFn: (data, selectedData) => data == selectedData,
            itemBuilder: (context, data, selected) => Card(
              elevation: 2,
              child: ListTile(
                selected: selected,
                title: Text(decodeNCRProvinces(data.code ?? "") ?? data.name!),
              ),
            ),
            onChanged: (ProvinceModel? data) async {
              selectedProvince = data;
              if (data != null) {
                context.loaderOverlay.show();
                try {
                  await fetchCityMunicipality(selectedProvince);
                  await fetchBrgys(
                    selectedProvince,
                    selectedCityMunicipality,
                  );
                } on HttpException catch (e) {
                  CustomAnimatedDialog.error(context, message: e.message);
                }
                context.loaderOverlay.hide();
              } else {
                setState(() {
                  selectedBrgy = null;
                  selectedCityMunicipality = null;
                  _citiesMunicipalities.value = [];
                  _brgys.value = [];
                });
              }
            },
          );
        });
  }

  ValueListenableBuilder _municipalityField() {
    return ValueListenableBuilder<List<CityMunicipalityModel>>(
        valueListenable: _citiesMunicipalities,
        builder: (context, citiesMunicipalities, _) {
          return MyCustomDropdownSearch<CityMunicipalityModel>(
            autoValidateMode: AutovalidateMode.always,
            labelText: "City/Municipality",
            selectedItem: selectedCityMunicipality,
            itemAsString: (data) => data!.name,
            prefixIcon: const Icon(Icons.location_city_rounded),
            items: citiesMunicipalities,
            compareFn: (data, selectedData) => data == selectedData,
            itemBuilder: (context, data, selected) => Card(
              elevation: 2,
              child: ListTile(
                selected: selected,
                title: Text(data.name),
              ),
            ),
            onChanged: (CityMunicipalityModel? data) async {
              selectedCityMunicipality = data;
              if (data != null) {
                context.loaderOverlay.show();
                await fetchBrgys(
                  selectedProvince,
                  selectedCityMunicipality,
                );
                context.loaderOverlay.hide();
              } else {
                setState(() {
                  selectedBrgy = null;
                  _brgys.value = [];
                });
              }
            },
          );
        });
  }

  ValueListenableBuilder<List<BrgyModel>> _brgyField() {
    return ValueListenableBuilder(
      valueListenable: _brgys,
      builder: (context, brgys, _) {
        return MyCustomDropdownSearch<BrgyModel>(
          autoValidateMode: AutovalidateMode.always,
          labelText: "Brgy  ",
          selectedItem: selectedBrgy,
          itemAsString: (data) => data!.name,
          prefixIcon: const Icon(Icons.location_city_rounded),
          items: brgys,
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
      },
    );
  }
}
