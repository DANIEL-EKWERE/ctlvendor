import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/ProductListScreen/model/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

class Productlistcontroller extends GetxController {
  Rx<bool> isLoading = false.obs;
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  ProductModel productModel = ProductModel();
  List<Data> products = <Data>[];
  @override
  onInit() {
    super.onInit();
    fetchProducts();
  }

  List<String> header = [
    'Product Name',
    "Category",
    'Pack',
    'Price',
    'Stock',
    'status',
  ];

  // List<Product> products = <Product>[
  //   Product(
  //     status: true,
  //     message:'',
  //     da
  //     name: 'Dangote sugar',
  //     categoryId: '1',
  //     pack: '100 mil',
  //     categoryName: 'Snacks',
  //     cost: 20,
  //     createdAt: 'Today',
  //     description: 'this is a demo desc',
  //     id: 1,
  //     isActive: true,
  //     packId: '2',
  //     price: 20,
  //     sku: 'sku',
  //     stock: 20,
  //   ),
  //   Product(
  //     name: 'Dangote cement',
  //     categoryId: '1',
  //     pack: '100 mil',
  //     categoryName: 'Snacks',
  //     cost: 20,
  //     createdAt: 'Today',
  //     description: 'this is a demo desc',
  //     id: 1,
  //     isActive: true,
  //     packId: '2',
  //     price: 20,
  //     sku: 'sku',
  //     stock: 20,
  //   ),
  // ];

  Future<void> deleteProduct(int id) async {}

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
}
