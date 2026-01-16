import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/main.dart';
import 'dart:convert';
import 'dart:developer' as myLog;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:ctlvendor/screens/login/models/models.dart';

import 'package:ctlvendor/utils/storage.dart';
import 'package:overlay_kit/overlay_kit.dart';

class LoginController extends GetxController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  RxBool isButtonEnabled = false.obs;

  RxBool isLoading = false.obs;
  // bool get isLoading => _isLoading;

  LoginModel loginModel = LoginModel(
    status: true,
    message: '',
    data: LoginData(),
  );
  LoginData data = LoginData();

  // set isLoading(bool value) {
  //   _isLoading = value;
  //   update();
  // }

  ApiClient _apiService = ApiClient(Duration(seconds: 60 * 5));

  Future<void> login() async {
    // if (!_formKey.currentState!.validate()) {
    //   return;
    // }

    // Save context early before any async operations
    final BuildContext? context = Get.context;

    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    isLoading.value = true;

    try {
      final response = await _apiService.login({
        'email': emailController.text,
        'password': passwordController.text,
      });

      isLoading.value = false;
      OverlayLoadingProgress.stop();

      if (response.statusCode == 200 || response.statusCode == 201) {
        loginModel = loginModelFromJson(response.body);
        data = loginModel.data;

        // Save token and user data to shared preferences
        await dataBase.saveToken(data.token ?? 'N/A');
        await dataBase.saveUserId((data.id!.toInt()).toString());
        await dataBase.saveFirstName(data.firstname ?? 'N/A');
        await dataBase.saveLastName(data.lastname ?? 'N/A');
        await dataBase.saveFullName(data.name ?? 'N/A');
        await dataBase.saveEmail(data.email ?? 'N/A');
        await dataBase.savePhoneNumber(data.phoneNumber ?? 'N/A');
        await dataBase.saveRole(data.role ?? 'N/A');
        await dataBase.saveReferalCode(data.referralCode ?? 'N/A');
        await dataBase.saveReferalCount(data.referralCount ?? 'N/A');
        await dataBase.saveRefererId(data.referrerId ?? 'N/A');

        emailController.clear();
        passwordController.clear();

        // Use Get.snackbar instead of ScaffoldMessenger
        Get.snackbar(
          'Success',
          loginModel.message ?? 'Login successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );

        // Navigate to dashboard
        Get.offAllNamed('/dashboard');
      } else {
        // Handle error response
        var errorData = jsonDecode(response.body);
        String errorMessage = errorData['message'] ?? 'Login failed';

        Get.snackbar(
          'Error',
          errorMessage,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
          duration: Duration(seconds: 3),
        );
      }
    } catch (e) {
      isLoading.value = false;
      OverlayLoadingProgress.stop();

      myLog.log('Login error: ${e.toString()}');

      // Use Get.snackbar instead of ScaffoldMessenger
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: Duration(seconds: 3),
      );
    } finally {
      isLoading.value = false;
      OverlayLoadingProgress.stop();
    }
  }
}
