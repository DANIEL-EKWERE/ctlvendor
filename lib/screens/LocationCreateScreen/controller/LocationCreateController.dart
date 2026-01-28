import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/LocationListScreen/controller/LocationListController.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/country_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/lga_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/state_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

import 'package:overlay_kit/overlay_kit.dart';

class LocationCreateController extends GetxController {
  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));
  CountryData? selectedCountry;
  String? selectedCountry1;
  int? selectedCountryId;
  StateData? selectedState;
  String? selectedState1;
  int? selectedStateId;
  LgaData? selectedLGA;
  String? selectedLGA1;
  int? selectedLGAId;
  Rx<bool> isActive = false.obs;
  RxBool isDefault = false.obs;
  TextEditingController contactAddressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();

  //TODO: edit controller

  TextEditingController edtContactAddressController = TextEditingController();
  TextEditingController editContactNumberController = TextEditingController();
  //ProfileController profileController = Get.put(ProfileController());
  List<String> countries = [];
  CountryModel countryModel = CountryModel();
  CountryData selectedCountryData = CountryData();
  List<CountryData> countryDataList = [];
  StateModel stateModel = StateModel();
  StateData selectedStateData = StateData();
  List<StateData> stateDataList = [];
  LgaModel lgaModel = LgaModel();
  LgaData selectedLGAData = LgaData();
  List<LgaData> lgaDataList = [];
  List<String> states = [];
  List<String> lgas = [];
  Rx<String>? long = ''.obs;
  Rx<String>? lat = ''.obs;

  @override
  void onInit() {
    super.onInit();
    myLog.log('CheckoutAddressChangeController initialized');
    fetchCountries();
    // fetchStates();
    // fetchLgas('Lagos');
  }

  LocationListController controller = Get.find<LocationListController>();
  isValid() {
    return selectedCountryId != null &&
        selectedStateId != null &&
        selectedLGAId != null &&
        contactAddressController.text.isNotEmpty &&
        contactNumberController.text.isNotEmpty;
  }

  RxBool isLoading = false.obs;
  RxBool isCountryLoading = false.obs;
  RxBool isStateLoading = false.obs;
  RxBool isLgaLoading = false.obs;

  fetchCountries() async {
    isCountryLoading.value = true;

    final response = await _apiService.fetchCountry();
    if (response.statusCode == 200 || response.statusCode == 201) {
      countryModel = countryModelFromJson(response.body);
      countries = countryModel.data!.map((e) => e.name!).toList();
      countryDataList = countryModel.data!;
      isCountryLoading.value = false;
      myLog.log(
        'Countries fetched successfully: ${countries.length} countries loaded.',
      );
      myLog.log('Countries: ${countries.join(', ')}');
    } else {
      isCountryLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load countries: ${response.body}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> storeAddress() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));

    try {
      var body = {
        "phone_number": contactNumberController.text,
        "contact_address": contactAddressController.text,
        "state_id": selectedStateId,
        "lga_id": selectedLGAId,
        "country_id": selectedCountryId,
        "is_default": isActive.value,
        "lat": lat!.isEmpty ? 5.01135 : lat?.value,
        "lon": long!.isEmpty ? 7.91752 : long?.value,
      };
      final response = await _apiService.storeAddress(body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        controller.fetchLocations();

        myLog.log('address stored successfully.');
        //myLog.log('Countries: ${countries.join(', ')}');
      } else {
        OverlayLoadingProgress.stop();
        Get.snackbar(
          'Error',
          'Failed to load countries: ${response.body}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      myLog.log('Error storing address: $e');
      Get.snackbar(
        'Error',
        'Error storing address: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> updateAddress(String addressId) async {
    myLog.log('message === ${addressId}');
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));

    try {
      var body = {
        "phone_number": editContactNumberController.text,
        "contact_address": edtContactAddressController.text,
        "state_id": selectedStateId,
        "lga_id": selectedLGAId,
        "country_id": selectedCountryId,
        "is_default": isActive.value,
        "lat": lat?.value == ""
            ? 5.01135
            : double.parse(lat?.value ?? "5.01135"),
        "lon": long?.value == ""
            ? 7.91752
            : double.parse(long?.value ?? "7.91752"),
      };
      final response = await _apiService.updateAddress(body, addressId);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        controller.fetchLocations();

        myLog.log('address stored successfully.');
        //myLog.log('Countries: ${countries.join(', ')}');
      } else {
        OverlayLoadingProgress.stop();
        Get.snackbar(
          'Error',
          'Failed to load countries: ${response.body}',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      myLog.log('Error storing address: $e');
      Get.snackbar(
        'Error',
        'Error storing address: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  fetchStates() async {
    isStateLoading.value = true;

    final response = await _apiService.fetchState();
    if (response.statusCode == 200 || response.statusCode == 201) {
      stateModel = stateModelFromJson(response.body);
      states = stateModel.data!.map((e) => e.name!).toList();
      stateDataList = stateModel.data!;
      isStateLoading.value = false;
      myLog.log('States fetched successfully: ${states.length} states loaded.');
      myLog.log('States: ${states.join(', ')}');
    } else {
      isStateLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load states: ${response.body}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  fetchLgas(String name) async {
    isLgaLoading.value = true;

    final response = await _apiService.fetchLgas(name);
    if (response.statusCode == 200 || response.statusCode == 201) {
      lgaModel = lgaModelFromJson(response.body);
      lgas = lgaModel.data!.map((e) => e.name!).toList();
      lgaDataList = lgaModel.data!;
      isLgaLoading.value = false;
      myLog.log('LGAs fetched successfully: ${lgas.length} LGAs loaded.');
      myLog.log('LGAs: ${lgas.join(', ')}');
    } else {
      isLgaLoading.value = false;
      Get.snackbar(
        'Error',
        'Failed to load LGAs: ${response.body}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      myLog.log('Failed to load LGAs: ${response.body}');
    }
  }
}
