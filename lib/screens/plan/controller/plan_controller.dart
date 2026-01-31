import 'dart:convert';

import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/payment_method/payment_method.dart';
import 'package:ctlvendor/screens/plan/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'dart:developer' as myLog;
import 'package:http/http.dart' as http;

class PlanController extends GetxController {
  RxString selectedPlan = 'online'.obs;
  RxInt selectedPlanId = 0.obs;
  Rx<bool> isLoading = false.obs;
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  Plan plan = Plan();
  List<Data> planList = <Data>[];

  Future<void> updateVendorPlanId() async {
    try {
      OverlayLoadingProgress.start(circularProgressColor: Color(0XFF004BFD));

      if (selectedPlanId.value == 0) {
        throw Exception("Please select a plan before continuing");
      }

      var email = await dataBase.getEmail();
      if (email == null || email.isEmpty) {
        throw Exception("Email not found. Please login again.");
      }

      String url = '${apiClient.baseUrl}/profile-update/$email';

      await dataBase.savePlan(selectedPlan.value);

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers['Accept'] = 'application/json';
      request.fields['tax_number'] = '123456789';
      request.fields['plan_id'] = selectedPlanId.value.toString();

      myLog.log('Updating plan to ID: ${selectedPlanId.value}');

      var response = await request.send();
      var responseBody = await response.stream.bytesToString();

      myLog.log('Response (${response.statusCode}): $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        await dataBase.savePayment(selectedPlan.value);
        Get.snackbar(
          "Success",
          "Business Plan updated successfully",
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        Get.to(() => PaymentMethodScreen());
      } else {
        throw Exception("Server error: ${response.statusCode} - $responseBody");
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        e.toString().replaceAll('Exception: ', ''),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      myLog.log('Error in updateVendorPlanId: $e');
    } finally {
      OverlayLoadingProgress.stop();
    }
  }

  Future<void> getPlans() async {
    isLoading.value = true;
    try {
      var response = await apiClient.getPlans();
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        myLog.log('called plans');
        var responseBody = jsonDecode(response.body);
        myLog.log(responseBody.toString());
        plan = planfromJson(response.body);
        planList = plan.data!;
      } else {
        var responseBody = jsonDecode(response.body);
        Get.snackbar(
          "Error occurred:",
          responseBody,
          backgroundColor: Colors.red,
        );
      }
    } catch (e) {
      isLoading.value = false;
      myLog.log('somthing went wrong $e');
      Get.snackbar(
        "Error occurred:",
        e.toString(),
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading.value = false;
    }
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
      // request.fields['country_id'] = selectedCountryId.toString();
      // request.fields['state_id'] = selectedStateId.toString();
      // //business_type_id
      // request.fields['lga_id'] = selectedLGAId.toString();
      // request.fields['phone_number'] = contactNumberController.text;
      // request.fields['business_address'] = contactAddressController.text;
      // request.fields['tax_number'] = '0';
      request.fields['plan_id'] = selectedPlanId.value.toString();

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
        var responseBody = await response.stream.bytesToString();

      myLog.log('Response (${response.statusCode}): $responseBody');
        // await dataBase.saveLocation(
        //   '${selectedCountry1.toString()}, ${selectedState1.toString()}, ${selectedLGA1.toString()}, ${contactAddressController.text}',
        // );
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

        Get.to(() => PaymentMethodScreen());
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
