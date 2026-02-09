import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/screens/vendor_business/model/vendor_business_model.dart';
import 'package:ctlvendor/screens/business_screen/controller/business_controller.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as myLog;
import 'package:ctlvendor/utils/storage.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class VendorBusinessController extends GetxController {
  Rx<VendorBusinessModel?> model = Rx<VendorBusinessModel?>(null);
  ApiClient apiClient = ApiClient(Duration(milliseconds: 60 * 5));
  ImagePicker picker = ImagePicker();
  Rx<XFile?> businessLogoFile = Rx<XFile?>(null);
  Rx<XFile?> businessLogoBanner = Rx<XFile?>(null);
  VendorSuccessModel vendorSuccessModel = VendorSuccessModel(
    status: true,
    message: '',
  );

  VendorData vendorData = VendorData();

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is VendorBusinessModel) {
      model.value = arg;
    } else if (arg is BusinessController) {
      model.value = VendorBusinessModel.fromBusinessController(arg);
    }
  }

  void loadFromBusinessController(BusinessController bc) {
    model.value = VendorBusinessModel.fromBusinessController(bc);
  }

  Future<void> obtainBusinessLogoFromGallery() async {
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        businessLogoFile.value = file;
        myLog.log('Logo image selected from gallery: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking logo image from gallery: $e");
      Get.snackbar('Error', 'Failed to pick logo image from gallery');
    }
  }

  Future<void> obtainBusinessBannerFromGallery() async {
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        businessLogoBanner.value = file;
        myLog.log('Banner image selected from gallery: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking banner image from gallery: $e");
      Get.snackbar('Error', 'Failed to pick banner image from gallery');
    }
  }

  Future<void> updateVendorProfileBusinessName() async {
    // Validation: Check if at least one image is selected
    if (businessLogoFile.value == null && businessLogoBanner.value == null) {
      Get.snackbar(
        'Error',
        'Please select at least one image to upload',
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
      return;
    }

    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    var email = await dataBase.getEmail();

    try {
      String url = '${apiClient.baseUrl}/update-business-profile/$email';
      Map<String, String> headers = {'Accept': 'application/json'};

      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);

      // Add business logo image if available
      if (businessLogoFile.value != null) {
        myLog.log(
          'Adding business logo image: ${businessLogoFile.value!.path}',
        );
        XFile imageFile = businessLogoFile.value!;
        String mimeType = lookupMimeType(imageFile.path) ?? 'image/jpeg';
        String fileName = basename(imageFile.path);

        var multipartFile = await http.MultipartFile.fromPath(
          'logo',
          imageFile.path,
          filename: fileName,
          contentType: MediaType(
            mimeType.split('/')[0],
            mimeType.split('/')[1],
          ),
        );
        request.files.add(multipartFile);
        myLog.log('Logo file added to request');
      }

      // Add banner image if available
      if (businessLogoBanner.value != null) {
        myLog.log('Adding business banner: ${businessLogoBanner.value!.path}');
        XFile documentFile = businessLogoBanner.value!;
        String mimeType = lookupMimeType(documentFile.path) ?? 'image/jpeg';
        String fileName = basename(documentFile.path);

        var multipartFile = await http.MultipartFile.fromPath(
          'banner',
          documentFile.path,
          filename: fileName,
          contentType: MediaType(
            mimeType.split('/')[0],
            mimeType.split('/')[1],
          ),
        );
        request.files.add(multipartFile);
        myLog.log('Banner file added to request');
      }

      // Send the request
      myLog.log('Sending request to: $url');
      var response = await request.send();

      myLog.log('Response status: ${response.statusCode}');
      var responseBody = await response.stream.bytesToString();
      myLog.log('Response Body: $responseBody');

      if (response.statusCode == 200 || response.statusCode == 201) {
        OverlayLoadingProgress.stop();
        vendorSuccessModel = vendorSuccessModelFromJson(responseBody);
        vendorData = vendorSuccessModel.data!;

        Get.back();

        // ✅ FIXED: Save the correct paths for logo and banner
        if (vendorData.logo != null) {
          await dataBase.saveLogo(vendorData.logo!);
          myLog.log('Logo saved to database: ${vendorData.logo!}');
        }

        if (vendorData.banner != null) {
          await dataBase.saveBanner(vendorData.banner!);
          myLog.log('Banner saved to database: ${vendorData.banner}');
        }

        // Clear the files after successful upload
        businessLogoFile.value = null;
        businessLogoBanner.value = null;

        Get.snackbar(
          'Success',
          'Images updated successfully',
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        myLog.log('Profile updated successfully');
      } else {
        OverlayLoadingProgress.stop();
        myLog.log('Error: ${response.statusCode}, Response: $responseBody');
        Get.snackbar(
          "Error",
          "${response.statusCode} - $responseBody",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } catch (e) {
      OverlayLoadingProgress.stop();
      Get.snackbar(
        "Error occurred",
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      myLog.log('Exception: ${e.toString()}');
    } finally {
      OverlayLoadingProgress.stop();
    }
  }
}
