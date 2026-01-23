import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/PromotionListScreen/controller/PromotionListController.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;
import 'package:ctlvendor/screens/ProductListScreen/model/model.dart';
import 'package:overlay_kit/overlay_kit.dart';

class PromotionCreateController extends GetxController {
  TextEditingController promotionTitleController = TextEditingController();

  TextEditingController startDateController = TextEditingController();

  TextEditingController endDateController = TextEditingController();

  Rx<String> discountType = 'percentage'.obs;
  TextEditingController discountValueController = TextEditingController();

  // TODO: edit section

  TextEditingController editPromotionTitleController = TextEditingController();

  TextEditingController editStartDateController = TextEditingController();

  TextEditingController editEndDateController = TextEditingController();

  Rx<String> editDiscountType = 'percentage'.obs;
  TextEditingController editDiscountValueController = TextEditingController();
  // TextEditingController descriptionController =
  // TextEditingController();

  Rx<bool> isLoading = false.obs;
  Rx<bool> isActive = false.obs;

  String? productId;
  String? selectedProduct;

  PromotionListController controller = Get.find<PromotionListController>();

  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  ProductModel productModel = ProductModel();
  List<Data> products = <Data>[];
  @override
  onInit() {
    super.onInit();
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    isLoading.value = true;
    try {
      // final resendData = {
      //   'email': widget.email,
      // };

      // You might need to implement a resend OTP endpoint in your API service
      // For now, we'll reuse the registration endpoint
      final response = await apiClient.fetchProduct();

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        productModel = productModelFromJson(response.body);
        products = productModel.data!;
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
          SnackBar(
            content: Text('Failed to resend code: ${response.body}["message"]'),
          ),
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

  Future<void> createPromotion() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    isLoading.value = true;
    try {
      var body = {
        'vendor_id': await dataBase.getUserId(),
        'company_id': await dataBase.getCompanyId(),
        'title': promotionTitleController.text,
        'vendor_products[0]': productId,
        'starts_at': startDateController.text,
        'ends_at': endDateController.text,
        'type': discountType.value,
        'discount': discountValueController.text,
      };

      myLog.log(body.toString());
      // final resendData = {
      //   'email': widget.email,
      // };

      // You might need to implement a resend OTP endpoint in your API service
      // For now, we'll reuse the registration endpoint
      final response = await apiClient.createPromotion(body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        isLoading.value = false;
        //Get.back();
        controller.fetchPromotions();
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

  Future<void> updatePromotion(String id) async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    isLoading.value = true;
    try {
      var body = {
        'vendor_id': await dataBase.getUserId(),
        'company_id': await dataBase.getCompanyId(),
        'title': editPromotionTitleController.text,
        'vendor_products[0]': productId,
        'starts_at': editStartDateController.text,
        'ends_at': editEndDateController.text,
        'type': discountType.value,
        'discount': editDiscountValueController.text,
      };
      final response = await apiClient.updatePromotion(body, id);

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        isLoading.value = false;
        controller.fetchPromotions();
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
