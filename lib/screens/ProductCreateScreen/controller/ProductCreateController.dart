import 'dart:ui';

import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/PackListScreen/models/model.dart' as pack;
import 'package:ctlvendor/screens/ProductCreateScreen/models/adminProductModel.dart';
import 'package:ctlvendor/screens/ProductCreateScreen/models/productCategoryModel.dart'
    as cat;
import 'package:ctlvendor/screens/ProductListScreen/controller/ProductListController.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

import 'package:overlay_kit/overlay_kit.dart';

class ProductCreateController extends GetxController {
    Productlistcontroller controller = Get.find<Productlistcontroller>();
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  RxList<XFile> selectedImages = <XFile>[].obs;
  final ImagePicker _imagePicker = ImagePicker();
  Rx<bool> isLoading = false.obs;
  Rx<bool> isLoading1 = false.obs;
  Rx<bool> isLoading2 = false.obs;
  Rx<String> selectedProduct = ''.obs;
  Rx<String> selectedProductId = ''.obs;

  Rx<String> selectedPack = ''.obs;
  Rx<String> selectedPackId = ''.obs;

    Rx<String> selectedCategory = ''.obs;
  Rx<String> selectedCategoryId = ''.obs;
  Rx<int> isActive = 1.obs;

//TODO: edit variables


  Rx<String> selectedProduct1 = ''.obs;
  Rx<String> selectedProductId1 = ''.obs;

  Rx<String> selectedPack1 = ''.obs;
  Rx<String> selectedPackId1 = ''.obs;

    Rx<String> selectedCategory1 = ''.obs;
  Rx<String> selectedCategoryId1 = ''.obs;
  Rx<int> isActive1 = 1.obs;

  AdminProduct adminProduct = AdminProduct();
  TextEditingController priceController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController stockController = TextEditingController();
  TextEditingController costController = TextEditingController();
  TextEditingController skuController = TextEditingController();
//TODO: Edit controllers
  TextEditingController editPriceController = TextEditingController();
  TextEditingController editDescriptionController = TextEditingController();
  TextEditingController editStockController = TextEditingController();
  TextEditingController editCostController = TextEditingController();
  TextEditingController editSkuController = TextEditingController();

  List<Data> productList = [];

  cat.ProductCategory productCategory = cat.ProductCategory();

  List<cat.Data> categoryList = [];

  @override
  void onInit() {
    super.onInit();
    myLog.log("ProductCreateController initialized");
    fetchProducts();
    fetchPacks();
    fetchCategories();
  }

  // Image picker method
  Future<void> pickImage() async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        selectedImages.add(pickedFile);
        myLog.log('Image picked: ${pickedFile.path}');
      }
    } catch (e) {
      myLog.log('Error picking image: $e');
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  // Remove image from list
  void removeImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      selectedImages.removeAt(index);
      myLog.log('Image removed at index: $index');
    }
  }

  // Get image at index
  XFile? getImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      return selectedImages[index];
    }
    return null;
  }

  Future<void> createProduct() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    // myLog.log(email);
    //var email = await dataBase.getEmail();
    var companyId = await dataBase.getCompanyId();
    var vendorId = await dataBase.getVendorId();
    //var categoryId = await dataBase.getCategoryId();
    var userId = await dataBase.getUserId();
    myLog.log('Creating product with vendorId: $vendorId');
    //var
    try {
      String url =
          '${apiClient.baseUrl}/vendor/products'; // Replace with your API endpoint
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await dataBase.getToken()}',

        'Content-Type': 'multipart/form-data', // Important for multipart
      };

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      //  request.fields['order_cut_off_time'] = orderCutOffTimeController.text;
      // request.fields['earliest_pre_order_time'] =
      //     earlestPreOrderTimeController.text;
      //business_type_id
      request.fields['company_id'] = companyId.toString();

      request.fields['product_id'] = selectedProductId.value;

      request.fields['category_id'] = selectedCategoryId.value;

      request.fields['pack_id'] = selectedPackId.value;

      request.fields['price'] = priceController.text;

      request.fields['description'] = descriptionController.text;

      request.fields['status'] = isActive.value.toString();

      request.fields['vendor_id'] = userId.toString();

      request.fields['stock'] = stockController.text;

      request.fields['cost'] = costController.text;
      //request.fields['description'] = 'orderFulfilmentController.text';
      //businessDescriptionController.text;

      // Add selected images to request
      if (selectedImages.isNotEmpty) {
        myLog.log('Adding ${selectedImages.length} images to request');
        for (int i = 0; i < selectedImages.length; i++) {
          XFile imageFile = selectedImages[i];
          String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
          String fileName = basename(imageFile.path);

          // Convert image to MultipartFile and add it to the request
          var multipartFile = await http.MultipartFile.fromPath(
            'image_url', // API expects this field name
            imageFile.path,
            filename: fileName,
            contentType: MediaType(
              mimeType.split('/')[0],
              mimeType.split('/')[1],
            ),
          );
          request.files.add(multipartFile);
          myLog.log('Image $i added: $fileName');
        }
      }

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
        myLog.log('Response Body: $responseBody');
        //   // Refresh profile data
        //   fetchUserProfile();
        //   ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     const SnackBar(content: Text('Profile updated successfully')),
        //   );
        // } else {
        //   ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     SnackBar(content: Text('Failed to update profile: ${response.body}')),
        //   );

        priceController.clear();
        descriptionController.clear();
        stockController.clear();
        costController.clear();
        selectedImages.clear();
        Get.back();
        Get.snackbar("Success", "Profile updated successfully");
        myLog.log('Product created successfully');

        controller.fetchProducts();

        Get.back();
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


  Future<void> updateProduct() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    // myLog.log(email);
    //var email = await dataBase.getEmail();
    var companyId = await dataBase.getCompanyId();
    var vendorId = await dataBase.getVendorId();
    //var categoryId = await dataBase.getCategoryId();
    var userId = await dataBase.getUserId();
    myLog.log('Creating product with vendorId: $vendorId');
    //var
    try {
      String url =
          '${apiClient.baseUrl}/vendor/products'; // Replace with your API endpoint
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await dataBase.getToken()}',

        'Content-Type': 'multipart/form-data', // Important for multipart
      };

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      //  request.fields['order_cut_off_time'] = orderCutOffTimeController.text;
      // request.fields['earliest_pre_order_time'] =
      //     earlestPreOrderTimeController.text;
      //business_type_id
      request.fields['company_id'] = companyId.toString();

      request.fields['product_id'] = selectedProductId.value;

      request.fields['category_id'] = selectedCategoryId.value;

      request.fields['pack_id'] = selectedPackId.value;

      request.fields['price'] = priceController.text;

      request.fields['description'] = descriptionController.text;

      request.fields['status'] = isActive.value.toString();

      request.fields['vendor_id'] = userId.toString();

      request.fields['stock'] = stockController.text;

      request.fields['cost'] = costController.text;
      //request.fields['description'] = 'orderFulfilmentController.text';
      //businessDescriptionController.text;

      // Add selected images to request
      if (selectedImages.isNotEmpty) {
        myLog.log('Adding ${selectedImages.length} images to request');
        for (int i = 0; i < selectedImages.length; i++) {
          XFile imageFile = selectedImages[i];
          String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
          String fileName = basename(imageFile.path);

          // Convert image to MultipartFile and add it to the request
          var multipartFile = await http.MultipartFile.fromPath(
            'image_url', // API expects this field name
            imageFile.path,
            filename: fileName,
            contentType: MediaType(
              mimeType.split('/')[0],
              mimeType.split('/')[1],
            ),
          );
          request.files.add(multipartFile);
          myLog.log('Image $i added: $fileName');
        }
      }

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
        myLog.log('Response Body: $responseBody');
        //   // Refresh profile data
        //   fetchUserProfile();
        //   ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     const SnackBar(content: Text('Profile updated successfully')),
        //   );
        // } else {
        //   ScaffoldMessenger.of(Get.context!).showSnackBar(
        //     SnackBar(content: Text('Failed to update profile: ${response.body}')),
        //   );

        priceController.clear();
        descriptionController.clear();
        stockController.clear();
        costController.clear();
        selectedImages.clear();
        Get.back();
        Get.snackbar("Success", "Profile updated successfully");
        myLog.log('Product created successfully');

        controller.fetchProducts();

        Get.back();
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

  Future<void> fetchProducts() async {
    isLoading.value = true;

    try {
      var response = await apiClient.getProducts();
      if (response.statusCode == 200) {
        isLoading.value = false;
        //  var responseBody = await response.stream.bytesToString();
        // myLog.log('Products fetched successfully: $responseBody');
        adminProduct = adminProductFromJson(response.body);
        productList = adminProduct.data ?? [];
        // Parse and use the product data as needed
      } else {
        isLoading.value = false;
        Get.snackbar('Error', response.body, backgroundColor: Colors.red);
        myLog.log('Failed to fetch products: ${response.statusCode}');
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    }
  }

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

  pack.PackModel packModel = pack.PackModel();
  List<pack.Data> packs = <pack.Data>[];

  Future<void> fetchPacks() async {
    isLoading1.value = true;
    try {
      // final resendData = {
      //   'email': widget.email,
      // };

      // You might need to implement a resend OTP endpoint in your API service
      // For now, we'll reuse the registration endpoint
      final response = await apiClient.fetchPacks();

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading1.value = false;
        packModel = pack.packModelFromJson(response.body);
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
        isLoading1.value = false;
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(content: Text('Failed : ${response.body}["message"]')),
        );
      }
    } catch (e) {
      myLog.log(e.toString());
      isLoading1.value = false;
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
