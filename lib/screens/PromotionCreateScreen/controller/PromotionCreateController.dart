import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/PromotionListScreen/controller/PromotionListController.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;
import 'package:ctlvendor/screens/ProductListScreen/model/model.dart';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:path/path.dart';

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

  RxList<XFile> selectedImages = <XFile>[].obs;
  RxList<String> existingImageUrls = <String>[].obs; // For edit mode

  PromotionListController controller = Get.find<PromotionListController>();

  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  ProductModel productModel = ProductModel();
  final ImagePicker _imagePicker = ImagePicker();

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

  Future<void> createPromotion1() async {
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

  // Image picker and replace method
  Future<void> pickImageReplace(int index) async {
    try {
      final XFile? pickedFile = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 80,
      );
      if (pickedFile != null) {
        removeImage(index);
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

  // Remove existing image URL
  void removeExistingImage(int index) {
    if (index >= 0 && index < existingImageUrls.length) {
      existingImageUrls.removeAt(index);
      myLog.log('Existing image removed at index: $index');
    }
  }

  // Get image at index
  XFile? getImage(int index) {
    if (index >= 0 && index < selectedImages.length) {
      return selectedImages[index];
    }
    return null;
  }

  Future<void> createPromotion() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));

    // var companyId = await dataBase.getCompanyId();
    var vendorId = await dataBase.getVendorId();
    // var userId = await dataBase.getUserId();
    myLog.log('Creating product with vendorId: $vendorId');

    try {
      String url = '${apiClient.baseUrl}/vendor/promotions';
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await dataBase.getToken()}',
        'Content-Type': 'multipart/form-data',
      };

      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      request.fields['title'] = promotionTitleController.text;

      request.fields['company_id'] = await dataBase.getCompanyId();
      request.fields['vendor_products[0]'] = productId!;
      request.fields['starts_at'] = startDateController.text;
      request.fields['ends_at'] = endDateController.text;
      request.fields['status'] = isActive.value.toString();
      request.fields['vendor_id'] = await dataBase.getUserId();
      request.fields['type'] = discountType.value;
      request.fields['discount'] = discountValueController.text;

      // Add selected images to request (only local files)
      if (selectedImages.isNotEmpty) {
        myLog.log('Adding ${selectedImages.length} images to request');
        for (int i = 0; i < selectedImages.length; i++) {
          XFile imageFile = selectedImages[i];

          // Skip if it's a network URL (shouldn't happen in create, but safety check)
          if (imageFile.path.startsWith('http://') ||
              imageFile.path.startsWith('https://')) {
            myLog.log('Skipping network URL in create mode: ${imageFile.path}');
            continue;
          }

          String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
          String fileName = basename(imageFile.path);

          var multipartFile = await http.MultipartFile.fromPath(
            'image_url',
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

      var response = await request.send();
      myLog.log('Response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        var responseBody = await response.stream.bytesToString();
        myLog.log('Response Body: $responseBody');

        // priceController.clear();
        // descriptionController.clear();
        // stockController.clear();
        // costController.clear();
        // selectedImages.clear();

        Get.snackbar("Success", "Promotion created successfully");
        myLog.log('Promotion created successfully');
        controller.fetchPromotions();
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

  Future<void> deactivatePromotion(
    String productId,
    String newStatus,
    String categoryId,
    String price,
    String stock,
    String packId,
  ) async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));

    var companyId = await dataBase.getCompanyId();
    var vendorId = await dataBase.getVendorId();
    var userId = await dataBase.getUserId();
    myLog.log('Updating product $productId with vendorId: $vendorId');

    try {
      // Use PUT or PATCH for updates, adjust URL to include product ID
      String url = '${apiClient.baseUrl}/vendor/products/$productId';
      Map<String, String> headers = {
        'Accept': 'application/json',
        'Authorization': 'Bearer ${await dataBase.getToken()}',
        'Content-Type': 'multipart/form-data',
      };

      // Use POST with _method field for Laravel
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      // request.fields['_method'] = 'PUT'; // Laravel method spoofing

      request.fields['company_id'] = companyId.toString();
      request.fields['product_id'] = productId;
      request.fields['category_id'] = categoryId;
      request.fields['pack_id'] = packId;
      request.fields['price'] = price;
     // request.fields['description'] = descriptionController.text;
      request.fields['status'] = newStatus;
      request.fields['vendor_id'] = userId.toString();
      request.fields['stock'] = stock;
    //  request.fields['cost'] = costController.text;
      // // Send existing image URLs as a field (if your API supports it)
      // if (existingImageUrls.isNotEmpty) {
      //   myLog.log('Including ${existingImageUrls.length} existing images');
      //   for (int i = 0; i < existingImageUrls.length; i++) {
      //     request.fields['existing_images[$i]'] = existingImageUrls[i];
      //   }
      // }

      // // Add ONLY new local images to request
      // if (selectedImages.isNotEmpty) {
      //   myLog.log('Adding ${selectedImages.length} NEW images to request');
      //   for (int i = 0; i < selectedImages.length; i++) {
      //     XFile imageFile = selectedImages[i];

      //     // ✅ CRITICAL FIX: Skip network URLs - they're already on the server
      //     if (imageFile.path.startsWith('http://') ||
      //         imageFile.path.startsWith('https://')) {
      //       myLog.log('Skipping existing network URL: ${imageFile.path}');
      //       continue;
      //     }

      //     String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
      //     String fileName = basename(imageFile.path);

      //     var multipartFile = await http.MultipartFile.fromPath(
      //       'new_images[]', // Use different field name for new images
      //       imageFile.path,
      //       filename: fileName,
      //       contentType: MediaType(
      //         mimeType.split('/')[0],
      //         mimeType.split('/')[1],
      //       ),
      //     );
      //     request.files.add(multipartFile);
      //     myLog.log('New image $i added: $fileName');
      //   }
      // }

      var response = await request.send();
      myLog.log('Response status: ${response.statusCode}');

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        //  Get.back();
        fetchProducts();
        var responseBody = await response.stream.bytesToString();
        myLog.log('Response Body: $responseBody');

        // Clear edit controllers and images
        // priceController.clear();
        // descriptionController.clear();
        // stockController.clear();
        // costController.clear();
        selectedImages.clear();

        Get.snackbar("Success", "Product deactivated successfully");
        myLog.log('Product deactivated successfully');
       // controller.fetchProducts();
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
      myLog.log('Error deactivating product: ${e.toString()}');
    } finally {
      OverlayLoadingProgress.stop();
    }
  }
}
