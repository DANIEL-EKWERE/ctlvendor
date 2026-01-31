import 'dart:developer' as myLog;
import 'package:ctlvendor/screens/plan/plan_screen.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/country_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/lga_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/state_model.dart';
import 'package:ctlvendor/screens/profile_screen/controller/profile_controller.dart';
import 'package:http/http.dart' as http;
import 'package:overlay_kit/overlay_kit.dart';

class AddLocationcontroller extends GetxController {
  // Rx<String> selectedCountryId = ''.obs;
  //   Rx<String> selectedStateId = ''.obs;
  Rx<String> selectedLgaId = ''.obs;

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
  RxBool isDefault = false.obs;
  TextEditingController contactAddressController = TextEditingController();
  TextEditingController contactNumberController = TextEditingController();
  ProfileController profileController = Get.put(ProfileController());
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

  processUpdateCheckoutAddress() {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    if (isValid()) {
      isLoading.value = true;
      final Map<String, dynamic> addressData = {
        'country_id': selectedCountryId,
        'state_id': selectedStateId,
        'lga_id': selectedLGAId,
        'contact_address': contactAddressController.text,
        'phone_number': contactNumberController.text,
        'is_default': isDefault.value,
        "lat": lat!.isEmpty ? 5.01135 : lat?.value,
        "lon": long!.isEmpty ? 7.91752 : long?.value,
      };

      myLog.log('Updating address data: $addressData');
      _apiService
          .updateCheckoutAddress(addressData)
          .then((response) {
            isLoading.value = false;
            if (response.statusCode == 200 || response.statusCode == 201) {
              OverlayLoadingProgress.stop();
              myLog.log('Address updated successfully: ${response.body}');
              Get.snackbar(
                'Success',
                'Address updated successfully.',
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );

              if (Navigator.canPop(Get.context!)) {
                print('Can pop the current route');
                //     Get.back(result: {
                //   'country': selectedCountry1,
                //   'state': selectedState1,
                //   'lga': selectedLGA1,
                //   'contact_address': contactAddressController.text,
                //   'phone_number': contactNumberController.text,
                //   'is_default': isDefault.value.toString(),
                // });
                Get.back(result: addressData);
                Navigator.pop(Get.context!, {
                  'country': selectedCountry1,
                  'state': selectedState1,
                  'lga': selectedLGA1,
                  'contact_address': contactAddressController.text,
                  'phone_number': contactNumberController.text,
                  'is_default': isDefault.value.toString(),
                  "lat": lat!.isEmpty ? 5.01135 : lat?.value,
                  "lon": long!.isEmpty ? 7.91752 : long?.value,
                });
              } else {
                OverlayLoadingProgress.stop();
                print('Cannot pop the current route');
              }
            } else {
              OverlayLoadingProgress.stop();
              Get.snackbar(
                'Error',
                'Failed to update address: ${response.body}',
                backgroundColor: Colors.red,
                colorText: Colors.white,
              );
            }
          })
          .catchError((error) {
            OverlayLoadingProgress.stop();
            isLoading.value = false;
            Get.snackbar(
              'Error',
              'An error occurred: $error',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          });
    } else {
      OverlayLoadingProgress.stop();
      Get.snackbar(
        'Error',
        'Please select a country, state, and LGA.',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  storeAddress() {
    // Store the address data in shared preferences or any local storage
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    final Map<String, dynamic> addressData = {
      'country_id': selectedCountryId,
      'state_id': selectedStateId,
      'lga_id': selectedLGAId,
      'contact_address': contactAddressController.text,
      'phone_number': contactNumberController.text,
      'is_default': isDefault.value,
      "lat": lat!.isEmpty ? 5.01135 : lat?.value,
      "lon": long!.isEmpty ? 7.91752 : long?.value,
    };

    myLog.log('Storing address data: $addressData');
    //  Call a method to save this data
    _apiService
        .addCheckoutAddress(addressData)
        .then((response) async {
          if (response.statusCode == 200 || response.statusCode == 201) {
            OverlayLoadingProgress.stop();
            myLog.log('Address stored successfully: ${response.body}');
            Get.snackbar(
              'Success',
              'Address stored successfully.',
              backgroundColor: Colors.green,
              colorText: Colors.white,
            );
            // Get.back();
            if (Navigator.canPop(Get.context!)) {
              print('Can pop the current route');
              Navigator.pop(Get.context!, {
                'country': selectedCountry1,
                'state': selectedState1,
                'lga': selectedLGA1,
                'contact_address': contactAddressController.text,
                'phone_number': contactNumberController.text,
                'is_default': isDefault.value.toString(),
                "lat": lat!.isEmpty ? 5.01135 : lat?.value,
                "lon": long!.isEmpty ? 7.91752 : long?.value,
              });
            } else {
              OverlayLoadingProgress.stop();
              print('Cannot pop the current route');
            }
            Future.delayed(Duration(milliseconds: 100), () {
              profileController.fetchUserProfile();
            });
          } else {
            OverlayLoadingProgress.stop();
            Get.snackbar(
              'Error',
              'Failed to store address: ${response.body}',
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
          }
        })
        .catchError((error) {
          OverlayLoadingProgress.stop();
          Get.snackbar(
            'Error',
            'An error occurred while storing address: $error',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        });
  }

  Future<void> updateVendorBusinessLocation() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    // myLog.log(email);
    // myLog.log("oder cut off  ${orderCutOffTimeController.text}");
    // myLog.log("ealset pre order ${earlestPreOrderTimeController.text}");
    // myLog.log("oder fulfilment ${orderFulfilmentController.text}");
    // myLog.log(fullfillmentType.value);
    var email = await dataBase.getEmail();
    try {
      String url =
          '${apiClient.baseUrl}/update-business-profile/$email'; // Replace with your API endpoint
      Map<String, String> headers = {
        'Accept': 'application/json',

        //'Content-Type': 'multipart/form-data', // Important for multipart
      };

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields['country_id'] = selectedCountryId.toString();
      request.fields['state_id'] = selectedStateId.toString();
      //business_type_id
      request.fields['lga_id'] = selectedLGAId.toString();
      request.fields['phone_number'] = contactNumberController.text;
      request.fields['business_address'] = contactAddressController.text;
      // request.fields['tax_number'] = '0';
      // request.fields['plan_id'] = '0';

      //businessDescriptionController.text;

      // if (file1.value != null) {
      //   myLog.log('profile photo adding');
      //   XFile? imageFile = file1.value;
      //   String mimeType = lookupMimeType(imageFile!.path) ?? 'image/jpeg';
      //   String fileName = basename(imageFile.path);

      //   // Convert image to MultipartFile and add it to the request
      //   var multipartFile1 = await http.MultipartFile.fromPath(
      //     'profile_picture', // The name of the field in your API
      //     imageFile.path,
      //     filename: fileName,
      //     contentType:
      //         MediaType(mimeType.split('/')[0], mimeType.split('/')[1]),
      //   );
      //   request.files.add(multipartFile1);
      // }

      // Send the request
      var response = await request.send();
      print(response.headers);
      print(response.stream);
      print(response.request);
      myLog.log('Response status: ${response.statusCode}');
      myLog.log('Response headers: ${response.headers}');
      myLog.log('Response request: ${response.request}');
      // var responseBody = await response.stream.bytesToString();
      //   myLog.log('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        await dataBase.saveLocation(
          '${selectedCountry1.toString()}, ${selectedState1.toString()}, ${selectedLGA1.toString()}, ${contactAddressController.text}',
        );
        await dataBase.savePhoneNumber(contactNumberController.text);
        // var responseBody = await response.stream.bytesToString();
        // myLog.log('Response Body: $responseBody');
        //   // Refresh profile data
        //   fetchUserProfile();
        //   ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     const SnackBar(content: Text('Profile updated successfully')),
        //   );
        // } else {
        //   ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     SnackBar(content: Text('Failed to update profile: ${response.body}')),
        //   );
        Get.snackbar("Success", "Profile updated successfully");
        myLog.log('Profile updated successfully');

        Get.to(
          () =>
              //SummaryScreen(),
              PlanScreen(),
        );
      } else {
        OverlayLoadingProgress.stop();
        var responseBody = await response.stream.bytesToString();
        print('Error: ${response.statusCode}, Response: $responseBody');
        Get.snackbar("Error:", " ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      Get.snackbar("Error occurred:", e.toString());
      myLog.log(e.toString());
    } finally {
      OverlayLoadingProgress.stop();
    }
  }
}
