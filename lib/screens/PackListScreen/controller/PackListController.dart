import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/PackListScreen/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

class PackListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));

  PackModel packModel = PackModel();
  List<Data> packs = <Data>[];
  @override
  onInit() {
    super.onInit();
    fetchPacks();
  }
  // List<String> header = [
  //   'Name',
  //   "Description",
  //   'Product Count',
  //   'Status',
  //   'Action',
  // ];

  // List<Pack> packs = <Pack>[
  //   Pack(
  //     name: 'Single Unit',
  //     priceModifier: 0,

  //   ),
  //   Pack(
  //     name: 'Pack of 6',
  //     priceModifier: -5,

  //   ),

  //   Pack(
  //     name: 'Pack of 12',
  //     priceModifier: -10,
  //   ),
  //   Pack(
  //     name: 'Carton (24)',
  //     priceModifier: -15,
  //   ),

  //   Pack(
  //     name: '500ml Bottle',
  //    priceModifier: 0
  //   ),
  //  Pack(
  //     name: '1 Litre',
  //     priceModifier: 2
  //   ),
  // ];

  Future<void> deleteProduct(int id) async {}

  Future<void> fetchPacks() async {
    isLoading.value = true;
    try {
      // final resendData = {
      //   'email': widget.email,
      // };

      // You might need to implement a resend OTP endpoint in your API service
      // For now, we'll reuse the registration endpoint
      final response = await apiClient.fetchPacks();

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        packModel = packModelFromJson(response.body);
        packs = packModel.data!;
        // resendSeconds.value = 240;
        // startResendTimer();
        // ScaffoldMessenger.of(Get.context!).showSnackBar(
        //   const SnackBar(
        //     content: Text('A new code has been sent to your email'),
        //     backgroundColor: Colors.amber,
        //   ),
        // );
        //_startCountdown();
      } else {
        isLoading.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed : ${response.body}["message"]')),
        );
      }
    } catch (e) {
      myLog.log(e.toString());
      isLoading.value = false;
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
