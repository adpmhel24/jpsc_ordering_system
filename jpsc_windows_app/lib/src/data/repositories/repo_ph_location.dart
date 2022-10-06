import 'dart:io';

import 'package:dio/dio.dart';

import '../http_services/ph_location_api/ph_location_api.dart';
import '../models/models.dart';

class PhLocationRepo {
  late List<ProvinceModel> _provinces = [];
  late List<CityMunicipalityModel> _citiesMunicipalities = [];
  late List<BrgyModel> _brgys = [];

  final PhLocationApiService _phApiService;

  PhLocationRepo(this._phApiService);

  List<ProvinceModel> get provinces =>
      [..._provinces..sort((a, b) => a.name!.compareTo(b.name!))];
  List<CityMunicipalityModel> get cities =>
      [..._citiesMunicipalities]..sort((a, b) => a.name.compareTo(b.name));
  List<BrgyModel> get brgys =>
      [..._brgys..sort((a, b) => a.name.compareTo(b.name))];

  late Map<String, dynamic> selectedProvinceCode = {};
  late String selectedCityMunicipalityCode = '';

  Future<void> fetchProvinces() async {
    Response provinceResponse;
    Response districtResponse;
    List<ProvinceModel> resultProvinces = [];
    try {
      provinceResponse = await _phApiService.fetchData('/provinces.json');
      districtResponse = await _phApiService.fetchData('/districts.json');
      if (provinceResponse.statusCode == 200) {
        // Add All Provinces
        resultProvinces.addAll(
          List<ProvinceModel>.from(
            provinceResponse.data
                .map((i) => ProvinceModel.fromJson(i))
                .toList(),
          ),
        );

        // Add District to provinces because NCR has no province.
        resultProvinces.addAll(
          List<ProvinceModel>.from(
            districtResponse.data.map((i) {
              i['name'] = "NCR, ${i['name']}";
              i['isDistrict'] = true;
              return ProvinceModel.fromJson(i);
            }).toList(),
          ),
        );

        _provinces = resultProvinces;
      }
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<List<ProvinceModel>> searchProvinceByKeyword(String keyword) async {
    Future.delayed(const Duration(seconds: 5));

    if (_provinces.isEmpty) {
      await fetchProvinces();
    }
    if (keyword.isNotEmpty) {
      return _provinces
          .where((e) => e.name!.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _provinces;
  }

  Future<void> fetchCitiesMunicipalities(
      ProvinceModel? selectedProvince) async {
    String path;
    if (selectedProvince != null) {
      if (selectedProvince.isDistrict) {
        path = "/districts/${selectedProvince.code}/cities-municipalities.json";
      } else {
        path = "/provinces/${selectedProvince.code}/cities-municipalities.json";
      }
    } else {
      path = '/cities-municipalities.json';
    }
    Response response;
    try {
      response = await _phApiService.fetchData(path);

      _citiesMunicipalities = List<CityMunicipalityModel>.from(
        response.data.map(
          (jsonCityMunicipality) =>
              CityMunicipalityModel.fromJson(jsonCityMunicipality),
        ),
      );
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<List<CityMunicipalityModel>> searchCityMunicipalityByKeyword(
      ProvinceModel? selectedProvinceCode, String keyword) async {
    await fetchCitiesMunicipalities(selectedProvinceCode);
    if (keyword.isNotEmpty) {
      return _citiesMunicipalities
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _citiesMunicipalities;
  }

  Future<void> fetchBrgys(
      {CityMunicipalityModel? selectedCityMunicapality,
      ProvinceModel? selectedProvince}) async {
    String path;
    if (selectedCityMunicapality != null) {
      path =
          '/cities-municipalities/${selectedCityMunicapality.code}/barangays.json';
    } else if (selectedProvince != null && !selectedProvince.isDistrict) {
      path = "/provinces/${selectedProvince.code}/barangays.json";
    } else if (selectedProvince != null && selectedProvince.isDistrict) {
      path = "/districts/${selectedProvince.code}/barangays.json";
    } else {
      path = "/barangays.json";
    }
    Response response;
    try {
      response = await _phApiService.fetchData(path);
      _brgys = List<BrgyModel>.from(
        response.data.map(
          (jsonBrgy) => BrgyModel.fromJson(jsonBrgy),
        ),
      ).toList();
    } on HttpException catch (e) {
      throw HttpException(e.message);
    }
  }

  Future<List<BrgyModel>> searchBarangaysByKeyword(
      {CityMunicipalityModel? selectedCityMunicapality,
      ProvinceModel? selectedProvince,
      required String keyword}) async {
    await fetchBrgys(
        selectedProvince: selectedProvince,
        selectedCityMunicapality: selectedCityMunicapality);
    if (keyword.isNotEmpty) {
      return _brgys
          .where((e) => e.name.toLowerCase().contains(keyword.toLowerCase()))
          .toList();
    }
    return _brgys;
  }

  void clear() {
    selectedProvinceCode.clear();
    selectedCityMunicipalityCode = '';
  }
}
