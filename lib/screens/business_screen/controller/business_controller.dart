import 'package:ctlvendor/utils/storage.dart';
import 'package:mime/mime.dart';
import 'package:overlay_kit/overlay_kit.dart';
import 'package:path/path.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:developer' as myLog;
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/data/apiClient/apiClient.dart';

class BusinessController extends GetxController {
  ApiClient apiClient = ApiClient(Duration(milliseconds: 60 * 5));
  TextEditingController businessNameController = TextEditingController();
  TextEditingController bvnController = TextEditingController();
  Rx<String> businessType = ''.obs;
  Rx<String> fullfillmentType = ''.obs;
  Rx<String> category = ''.obs;
  TextEditingController cacNoController = TextEditingController();
  TextEditingController taxNoController = TextEditingController();
  Rx<bool> isBusinessRegistered = false.obs;
  Rx<String> meansOfIdentification = ''.obs;
  TextEditingController contactAddressController = TextEditingController();
  TextEditingController businessDescriptionController = TextEditingController();
  //TextEditingController rcNumberController = TextEditingController();

  // Image picker
  ImagePicker picker = ImagePicker();
  Rx<XFile?> businessLogoFile = Rx<XFile?>(null);
  Rx<XFile?> businessDocumentFile = Rx<XFile?>(null);
  Rx<XFile?> identificationFile = Rx<XFile?>(null);

  Future<void> obtainImageFromGallery() async {
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        businessLogoFile.value = file;
        myLog.log('Image selected from gallery: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking image from gallery: $e");
      Get.snackbar('Error', 'Failed to pick image from gallery');
    }
  }

  Future<void> obtainImageFromCamera() async {
    try {
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        businessLogoFile.value = file;
        myLog.log('Image selected from camera: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking image from camera: $e");
      Get.snackbar('Error', 'Failed to pick image from camera');
    }
  }

  Future<void> obtainDocumentFromGallery() async {
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        businessDocumentFile.value = file;
        myLog.log('Document selected from gallery: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking document from gallery: $e");
      Get.snackbar('Error', 'Failed to pick document from gallery');
    }
  }

  Future<void> obtainDocumentFromCamera() async {
    try {
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        businessDocumentFile.value = file;
        myLog.log('Document selected from camera: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking document from camera: $e");
      Get.snackbar('Error', 'Failed to pick document from camera');
    }
  }

  Future<void> removeDocumentFile() async {
    businessDocumentFile.value = null;
    myLog.log('Document removed');
  }

  Future<void> obtainIdentificationFromGallery() async {
    try {
      final file = await picker.pickImage(source: ImageSource.gallery);
      if (file != null) {
        identificationFile.value = file;
        myLog.log('Identification image selected from gallery: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking identification image from gallery: $e");
      Get.snackbar('Error', 'Failed to pick identification image from gallery');
    }
  }

  Future<void> obtainIdentificationFromCamera() async {
    try {
      final file = await picker.pickImage(source: ImageSource.camera);
      if (file != null) {
        identificationFile.value = file;
        myLog.log('Identification image selected from camera: ${file.path}');
      }
    } catch (e) {
      myLog.log("Error picking identification image from camera: $e");
      Get.snackbar('Error', 'Failed to pick identification image from camera');
    }
  }

  Future<void> updateVendorProfileBusinessName() async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    // myLog.log(email);
    var email = await dataBase.getEmail();
    try {
      String url =
          '${apiClient.baseUrl}/update-business-profile/$email'; // Replace with your API endpoint
      Map<String, String> headers = {
        'Accept': 'application/json',

        //'Content-Type': 'multipart/form-data', // Important for multipart
      };
      myLog.log(businessType.value);
      myLog.log(businessType.value);
      // Create multipart request
      var request = http.MultipartRequest('POST', Uri.parse(url));
      request.headers.addAll(headers);
      request.fields['business_name'] = businessNameController.text;
      request.fields['business_address'] = contactAddressController.text;
      //business_type_id
      request.fields['business_type_id'] = businessType.value;
      //

      request.fields['fulfilment_type'] = fullfillmentType.value;

      request.fields['means_of_identification'] = meansOfIdentification.value;
      request.fields['tax_number'] = taxNoController.text;
      request.fields['business_description'] =
          businessDescriptionController.text;
      request.fields['bvn'] = bvnController.text;
      // request.fields['rc_number'] = rcNumberController.text;
      //is_registered
      request.fields['is_registered'] = isBusinessRegistered.value
          ? '1'
          : '0'; //businessDescriptionController.text;

      // Add business logo image if available
      if (businessLogoFile.value != null) {
        myLog.log('Adding business logo image');
        XFile? imageFile = businessLogoFile.value;
        String mimeType = lookupMimeType(imageFile!.path) ?? 'image/jpeg';
        String fileName = basename(imageFile.path);

        // Convert image to MultipartFile and add it to the request
        var multipartFile = await http.MultipartFile.fromPath(
          'logo', // The name of the field in your API
          imageFile.path,
          filename: fileName,
          contentType: MediaType(
            mimeType.split('/')[0],
            mimeType.split('/')[1],
          ),
        );
        request.files.add(multipartFile);
      }

      // Add business document if available
      if (businessDocumentFile.value != null) {
        myLog.log('Adding business document');
        XFile documentFile = businessDocumentFile.value!;
        String mimeType = lookupMimeType(documentFile.path) ?? 'image/jpeg';
        String fileName = basename(documentFile.path);

        // Convert document to MultipartFile and add it to the request
        var multipartFile = await http.MultipartFile.fromPath(
          'business_documents', // The name of the field in your API
          documentFile.path,
          filename: fileName,
          contentType: MediaType(
            mimeType.split('/')[0],
            mimeType.split('/')[1],
          ),
        );
        request.files.add(multipartFile);
      }

      // Add identification image if available
      if (identificationFile.value != null) {
        myLog.log('Adding identification image');
        XFile? identFile = identificationFile.value;
        String mimeType = lookupMimeType(identFile!.path) ?? 'image/jpeg';
        String fileName = basename(identFile.path);

        // Convert image to MultipartFile and add it to the request
        var multipartFile = await http.MultipartFile.fromPath(
          'identification_url', // The name of the field in your API
          identFile.path,
          filename: fileName,
          contentType: MediaType(
            mimeType.split('/')[0],
            mimeType.split('/')[1],
          ),
        );
        request.files.add(multipartFile);
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
        await dataBase.saveAddress(contactAddressController.text);
        businessNameController.clear();
        businessLogoFile.value =
            null; // Clear the image after successful upload
        businessDocumentFile.value =
            null; // Clear the document after successful upload
        identificationFile.value =
            null; // Clear the identification image after successful upload
        Navigator.pushNamed(Get.context!, '/product-selection');
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
