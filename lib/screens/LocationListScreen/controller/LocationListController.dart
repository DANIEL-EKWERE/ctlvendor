import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/LocationListScreen/models/model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LocationListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));
  LocationModel locationModel = LocationModel();
  @override
onInit(){
super.onInit();
fetchLocations();
}
  List<Data> locations = <Data>[]; 
  // List<String> header = [
  //   'Name',
  //   "Description",
  //   'Product Count',
  //   'Status',
  //   'Action',
  // ];

  // List<Location> locations = <Location>[
  //   Location(
  //     city: 'New York',
  //     state: 'NY',
  //     country: 'USA',
  //     phone: '+1 (555) 123-4567',
  //     isActive: true,
  //   ),
  //   Location(
  //     city: 'Los Angelos',
  //     state: 'CA',
  //     country: 'USA',
  //     phone: '+1 (555) 987-6543',
  //     isActive: true,
  //   ),
  // ];

  Future<void> deleteProduct(int id) async {}


  Future<void> fetchLocations() async {
  isLoading.value = true;
    try {
      // final resendData = {
      //   'email': widget.email,
      // };

      // You might need to implement a resend OTP endpoint in your API service
      // For now, we'll reuse the registration endpoint
      final response = await apiClient.fetchlocations();

      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        locationModel = locationModelFromJson(response.body);
        locations = locationModel.data!;
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
            content: Text('Failed : ${response.body}["message"]'),
          ),
        );
      }
    } catch (e) {
      isLoading.value = false;
      ScaffoldMessenger.of(
        Get.context!,
      ).showSnackBar(SnackBar(content: Text('Error: $e')));
    }
  }
}
