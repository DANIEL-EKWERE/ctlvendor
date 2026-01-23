import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/PromotionListScreen/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

class PromotionListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  PromotionModel promotionModel = PromotionModel();
  List<Data> promotions = <Data>[];
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  // List<Promotion> promotions = <Promotion>[
  //   Promotion(
  //     title: 'Summer Sale',
  //     discountValue: 20,
  //     startDate: '15/01/2026',
  //     endDate: '15/02/2026',
  //     isActive: true,
  //     productsCount: 2,
  //   ),
  @override
  onInit() {
    super.onInit();
    fetchPromotions();
  }

  //   Promotion(
  //     title: 'Buy 2 Get 10% Off',
  //     discountValue: 10,
  //     startDate: '10/01/2026',
  //     endDate: '31/01/2026',
  //     isActive: true,
  //     productsCount: 2,
  //   ),
  // ];

  Future<void> deleteProduct(int id) async {}

  Future<void> fetchPromotions() async {
    isLoading.value = true;
    try {
      final response = await apiClient.fetchPromotions();

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        promotionModel = promotionModelFromJson(response.body);
        promotions = promotionModel.data!;
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
