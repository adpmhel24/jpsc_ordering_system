import 'package:auto_route/auto_route.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../../../../data/models/models.dart';
import '../../../../../../data/repositories/repos.dart';
import '../../../../../../global_blocs/bloc_customer/creating_update_bloc/bloc.dart';
import '../../../../../../utils/constant.dart';
import '../../../../../../utils/responsive.dart';

class CustomerAddressFormModal extends StatefulWidget {
  const CustomerAddressFormModal({
    Key? key,
    required this.bloc,
    this.selectedAddressObj,
    this.currentIndex,
  }) : super(key: key);

  final CreateUpdateCustomerBloc bloc;
  final CustomerAddressModel? selectedAddressObj;
  final int? currentIndex;
  @override
  State<CustomerAddressFormModal> createState() =>
      _CustomerAddressFormModalState();
}

class _CustomerAddressFormModalState extends State<CustomerAddressFormModal> {
  final TextEditingController _otherDetailsController = TextEditingController();
  final TextEditingController _provinceController = TextEditingController();
  final TextEditingController _cityMunicipalityController =
      TextEditingController();
  final TextEditingController _brgyController = TextEditingController();
  final TextEditingController _streetAddressController =
      TextEditingController();

  final ValueNotifier<String> _streetAddress = ValueNotifier("");
  final ValueNotifier<List<ProvinceModel>> _provinces = ValueNotifier([]);
  final ValueNotifier<List<CityMunicipalityModel>> _citiesMunicipalities =
      ValueNotifier([]);
  final ValueNotifier<List<BrgyModel>> _brgys = ValueNotifier([]);
  late PhLocationRepo locationRepo;

  ProvinceModel? selectedProvince;
  CityMunicipalityModel? selectedCityMunicipality;
  BrgyModel? selectedBrgy;

  bool isDefault = false;

  @override
  void initState() {
    locationRepo = context.read<PhLocationRepo>();
    _otherDetailsController.text =
        widget.selectedAddressObj?.otherDetails ?? "";
    _provinceController.text = widget.selectedAddressObj?.province ?? "";
    _cityMunicipalityController.text =
        widget.selectedAddressObj?.cityMunicipality ?? "";
    _brgyController.text = widget.selectedAddressObj?.brgy ?? "";
    _streetAddress.value = widget.selectedAddressObj?.streetAddress ?? "";
    _streetAddressController.text = _streetAddress.value;
    isDefault = widget.selectedAddressObj?.isDefault ?? false;
    fetchProvinces();
    super.initState();
  }

  @override
  void dispose() {
    _provinces.dispose();
    _citiesMunicipalities.dispose();
    _brgys.dispose();
    _streetAddress.dispose();
    _otherDetailsController.dispose();
    _provinceController.dispose();
    _cityMunicipalityController.dispose();
    _brgyController.dispose();
    _streetAddressController.dispose();
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
    return ContentDialog(
      title: const Text("Address Form"),
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * .6,
        maxWidth: Responsive.isMobile(context)
            ? MediaQuery.of(context).size.width
            : 600,
      ),
      actions: [
        ValueListenableBuilder<String>(
            valueListenable: _streetAddress,
            builder: (_, street, ___) {
              return FilledButton(
                onPressed: street.isEmpty
                    ? null
                    : () {
                        CustomerAddressModel address = CustomerAddressModel(
                          id: widget.selectedAddressObj?.id,
                          streetAddress: _streetAddress.value,
                          brgy: _brgyController.text,
                          cityMunicipality: _cityMunicipalityController.text,
                          province: _provinceController.text,
                          otherDetails: _otherDetailsController.text,
                          isDefault: isDefault,
                        );
                        widget.bloc.add(
                          widget.currentIndex != null
                              // Update
                              ? CustAddressUpdated(
                                  widget.currentIndex!,
                                  address,
                                )
                              // Add New
                              : CustAddressAdded(
                                  address,
                                ),
                        );
                        context.router.pop();
                      },
                child:
                    Text(widget.selectedAddressObj != null ? "Update" : "Add"),
              );
            }),
        Button(
          child: const Text("Close"),
          onPressed: () => context.router.pop(),
        )
      ],
      content: ListView(
        children: [
          provinceField(context),
          Constant.heightSpacer,
          municipalityField(context),
          Constant.heightSpacer,
          brgyField(),
          Constant.heightSpacer,
          streetAddressField(),
          Constant.heightSpacer,
          otherDetailsField(),
          Constant.heightSpacer,
          Row(
            children: [
              Checkbox(
                content: const Text("isDefault"),
                checked: isDefault,
                onChanged: (v) => setState(
                  () {
                    isDefault = v!;
                  },
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  TextBox otherDetailsField() {
    return TextBox(
      header: "Other Details",
      controller: _otherDetailsController,
      minLines: 1,
      maxLines: 4,
    );
  }

  TextFormBox streetAddressField() {
    return TextFormBox(
      controller: _streetAddressController,
      header: "Street Address *",
      minLines: 1,
      maxLines: 4,
      onChanged: (value) {
        _streetAddress.value = value;
      },
    );
  }

  InfoLabel brgyField() {
    return InfoLabel(
      label: "Brgy",
      child: ValueListenableBuilder<List<BrgyModel>>(
        valueListenable: _brgys,
        builder: (_, citiesObj, __) {
          return AutoSuggestBox(
            trailingIcon: const Icon(FluentIcons.caret_down8),
            controller: _brgyController,
            items: citiesObj
                .map<AutoSuggestBoxItem>(
                  (brgy) => AutoSuggestBoxItem(
                    value: brgy.name,
                    onSelected: () {
                      selectedBrgy = brgy;
                    },
                  ),
                )
                .toList(),
            onChanged: (value, reason) {
              if (reason.name == "cleared") {
                setState(() {
                  _brgyController.text = "";
                  selectedBrgy = null;
                });
              }
            },
          );
        },
      ),
    );
  }

  InfoLabel municipalityField(BuildContext context) {
    return InfoLabel(
      label: "City / Municipality",
      child: ValueListenableBuilder<List<CityMunicipalityModel>>(
        valueListenable: _citiesMunicipalities,
        builder: (_, citiesObj, __) {
          return AutoSuggestBox(
            controller: _cityMunicipalityController,
            trailingIcon: const Icon(FluentIcons.caret_down8),
            items: citiesObj
                .map<AutoSuggestBoxItem>(
                  (city) => AutoSuggestBoxItem(
                    value: city.name,
                    onSelected: () async {
                      context.loaderOverlay.show();
                      selectedCityMunicipality = city;
                      await fetchBrgys(
                        selectedProvince,
                        selectedCityMunicipality,
                      );
                      context.loaderOverlay.hide();
                    },
                  ),
                )
                .toList(),
            onChanged: (_, reason) {
              if (reason.name == "cleared") {
                setState(() {
                  _cityMunicipalityController.text = "";
                  _brgyController.text = "";
                  selectedCityMunicipality = null;
                  selectedBrgy = null;
                });
              }
            },
          );
        },
      ),
    );
  }

  InfoLabel provinceField(BuildContext context) {
    return InfoLabel(
      label: "Province",
      child: ValueListenableBuilder<List<ProvinceModel>>(
        valueListenable: _provinces,
        builder: (_, provincesObj, __) {
          return AutoSuggestBox(
            controller: _provinceController,
            trailingIcon: const Icon(FluentIcons.caret_down8),
            items: provincesObj
                .map<AutoSuggestBoxItem>(
                  (provinceObj) => AutoSuggestBoxItem(
                    value: decodeNCRProvinces(provinceObj.code!) ??
                        provinceObj.name!,
                    child: Text(
                      decodeNCRProvinces(provinceObj.code!) ??
                          provinceObj.name!,
                      overflow: TextOverflow.ellipsis,
                    ),
                    onSelected: () async {
                      context.loaderOverlay.show();

                      await fetchCityMunicipality(provinceObj);
                      selectedProvince = provinceObj;
                      await fetchBrgys(
                        selectedProvince,
                        selectedCityMunicipality,
                      );

                      context.loaderOverlay.hide();
                    },
                  ),
                )
                .toList(),
            onChanged: (_, reason) {
              if (reason.name == "cleared") {
                setState(() {
                  _cityMunicipalityController.text = "";
                  selectedProvince = null;
                  selectedCityMunicipality = null;
                  _citiesMunicipalities.value = [];
                  if (selectedCityMunicipality == null) {
                    _citiesMunicipalities.value = [];
                    _brgyController.text = "";
                    selectedBrgy = null;
                  }
                });
              }
            },
          );
        },
      ),
    );
  }
}
