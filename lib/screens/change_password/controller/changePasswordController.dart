import 'dart:convert';

import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

class Changepasswordcontroller extends GetxController {
  TextEditingController newPassword = TextEditingController();
  TextEditingController confirmNewPassword = TextEditingController();
  ApiClient _apiClient = ApiClient(Duration(seconds: 60 * 5));

  Rx<bool> isLoading = false.obs;

  Future<void> changePassword() async {
    isLoading.value = true;
    try {
      String email = await dataBase.getEmail();
      myLog.log(email);
      var body = {
        "recipient": email,
        "password": newPassword.text,
        "password_confirmation": confirmNewPassword.text,
      };

      var response = await _apiClient.resetPassword(body);
      if (response.statusCode == 200 || response.statusCode == 201) {
        isLoading.value = false;
        dataBase.logOut();
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text('Success: Password Changed Successfully'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 3),
          ),
        );
        Get.offAllNamed('/login');
      } else {
        isLoading.value = false;
        var responseBody = jsonDecode(response.body);
        myLog.log(responseBody['errors']['password'].toList().toString());
        ScaffoldMessenger.of(Get.context!).showSnackBar(
          SnackBar(
            content: Text(
              'Error: ${responseBody['errors']['password'].toList()}',
            ),
            backgroundColor: Colors.red,
            duration: Duration(seconds: 10),
          ),
        );
      }
    } catch (e) {
      isLoading.value = false;
      myLog.log(e.toString());
      ScaffoldMessenger.of(Get.context!).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
          duration: Duration(seconds: 10),
        ),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
