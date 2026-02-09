import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/CategoryListScreen/models/model.dart';
import 'package:ctlvendor/screens/ProductCreateScreen/models/adminProductModel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/screens/ProductCreateScreen/models/productCategoryModel.dart'
    as cat;
    import 'dart:developer' as myLog;
class CategoryListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  List<String> header = [
    'Name',
    "Description",
    'Product Count',
    'Status',
    'Action',
  ];

  List<Category> categories = <Category>[
    Category(
      name: 'Beverages',
      description: 'Soft drinks and juices',
      productsCount: 12,
      isActive: true,
    ),
    Category(
      name: 'Snacks',
      description: 'Chips, nuts, and more',
      productsCount: 18,
      isActive: true,
    ),

    Category(
      name: 'Dairy',
      description: 'Milk and dairy products',
      productsCount: 2,
      isActive: true,
    ),
    Category(
      name: 'Bakery',
      description: 'Bread and baked goods',
      productsCount: 15,
      isActive: true,
    ),

    Category(
      name: 'Beverages',
      description: 'Soft drinks and juices',
      productsCount: 12,
      isActive: true,
    ),
    Category(
      name: 'Snacks',
      description: 'Chips, nuts, and more',
      productsCount: 18,
      isActive: true,
    ),
  ];

  Future<void> deleteProduct(int id) async {}
ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
AdminProduct adminProduct = AdminProduct();
List<Data> productList = [];
Rx<bool> isLoading2 = false.obs;

cat.ProductCategory productCategory = cat.ProductCategory();

  List<cat.Data> categoryList = [];

  Future<void> fetchCategories() async {
    
    isLoading2.value = true;

    try {
      var response = await apiClient.getProductCategories();
      if (response.statusCode == 200) {
        isLoading2.value = false;
        //  var responseBody = await response.stream.bytesToString();
        // myLog.log('Products fetched successfully: $responseBody');
        productCategory = cat.productCategoryFromJson(response.body);
        categoryList = productCategory.data ?? [];
        // Parse and use the product data as needed
      } else {
        isLoading2.value = false;
        Get.snackbar('Error', response.body, backgroundColor: Colors.red);
        myLog.log('Failed to fetch products: ${response.statusCode}');
      }
      isLoading2.value = false;
    } catch (e) {
      isLoading2.value = false;
      productList = adminProduct.data ?? [];
      // Parse and use the product data as needed

      isLoading2.value = false;
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

}
