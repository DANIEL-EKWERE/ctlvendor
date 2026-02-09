import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'dart:developer' as myLog;

import 'package:overlay_kit/overlay_kit.dart';

class BankSelectionController extends GetxController {
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));

  Rx<bool> isLoading = false.obs;

  Future<void> transferToBank(int amount, int bankId) async {
    OverlayLoadingProgress.start(circularProgressColor: Color(0xff004BFD));
    isLoading.value = true;

    try {
      var body = {
        "amount": amount,
        "bank_id": bankId,
        "currency": "NGN",
        "remark": "withdraw to bank",
      };

      myLog.log(body.toString());

      var response = await apiClient.transferToBank(body);
      if (response.statusCode == 200) {
        isLoading.value = false;
        OverlayLoadingProgress.stop();
        Get.dialog(
          AlertDialog(
            backgroundColor: Colors.transparent,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: SizedBox(
              height: 500,
              child: Container(
                // ignore: deprecated_member_use
                color: Colors.black.withOpacity(0.5),
                child: Center(
                  child: Container(
                    width: 300,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: BoxDecoration(
                            color: Colors.green.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.green,
                            size: 50,
                          ),
                        ),
                        const SizedBox(height: 24),
                        const Text(
                          'Payment Completed',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'Your withdrawal has been processed successfully.',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 14, color: Colors.black54),
                        ),
                        const SizedBox(height: 24),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushNamedAndRemoveUntil(
                              Get.context!,
                              '/dashboard',
                              (route) => false,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF004DBF),
                            minimumSize: const Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('Done'),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      } else {
        isLoading.value = false;
        Get.snackbar('Error', response.body, backgroundColor: Colors.red);
        OverlayLoadingProgress.stop();
      }
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      OverlayLoadingProgress.stop();
      isLoading.value = false;
      Get.snackbar('Error', e.toString(), backgroundColor: Colors.red);
    } finally {
      OverlayLoadingProgress.stop();
    }
  }
}
