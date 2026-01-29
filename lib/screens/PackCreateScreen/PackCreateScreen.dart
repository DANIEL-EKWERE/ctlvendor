import 'package:ctlvendor/screens/PackCreateScreen/controller/PackCreateController.dart';
import 'package:ctlvendor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';

//PackCreateController controller = Get.put(PackCreateController());

class PackCreateScreen extends StatelessWidget {
  PackCreateScreen(this.controller, {super.key});

  final PackCreateController controller;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.all(8),

        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text('Add Pack', style: TextStyle(fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: Icon(Icons.cancel_outlined),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text('Pack Name'),
            SizedBox(height: 5),
            TextField(
              controller: controller.packNameController,
              decoration: InputDecoration(
                hintText: 'Enter Pack Name',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text('Price Modifier (₦)'),
            SizedBox(height: 5),
            TextField(
              controller: controller.priceModifierController,
              decoration: InputDecoration(
                hintText: 'Enter Price',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                filled: true,
                fillColor: Colors.grey[50],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.grey[200]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
            ),
            SizedBox(height: 30),
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 90,
                  height: 50,
                  child: CustomButton(
                    isOutlined: true,
                    text: 'Cancel',
                    onPressed: () {
                      Get.back();
                    },
                  ),
                ),
                SizedBox(
                  width: 90,
                  height: 50,
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () {
                      Get.back();
                      controller.createPacks();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
