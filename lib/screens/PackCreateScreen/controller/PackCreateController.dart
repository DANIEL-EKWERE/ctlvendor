import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/PackListScreen/controller/PackListController.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

import 'package:overlay_kit/overlay_kit.dart';

class PackCreateController extends GetxController {
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  Rx<bool> isLoading = false.obs;

  var controller = Get.find<PackListController>();
  TextEditingController packNameController = TextEditingController();
  TextEditingController priceModifierController = TextEditingController();

  TextEditingController editPackNameController = TextEditingController();
  TextEditingController editPriceModifierController = TextEditingController();

  Future<void> createPacks() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    isLoading.value = true;
    try {
      var body = {
        'vendor_id': await dataBase.getUserId(),
        'company_id': await dataBase.getCompanyId(),
        'name': packNameController.text,
        'price': priceModifierController.text,
      };
      // final resendData = {
      //   'email': widget.email,
      // };

      // You might need to implement a resend OTP endpoint in your API service
      // For now, we'll reuse the registration endpoint
      final response = await apiClient.createPack(body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        isLoading.value = false;
        //Get.back();
        controller.fetchPacks();
      } else {
        OverlayLoadingProgress.stop();
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed : ${response.body}["message"]')),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      myLog.log(e.toString());
      isLoading.value = false;
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }

  Future<void> editPacks(String id) async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    isLoading.value = true;
    try {
      var body = {
        'vendor_id': await dataBase.getUserId(),
        'company_id': await dataBase.getCompanyId(),
        'name': editPackNameController.text,
        'price': editPriceModifierController.text,
      };
      final response = await apiClient.updatePack(body, id);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        isLoading.value = false;
        controller.fetchPacks();
        //  Get.back();
      } else {
        OverlayLoadingProgress.stop();
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed : ${response.body}["message"]')),
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      myLog.log(e.toString());
      isLoading.value = false;
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
