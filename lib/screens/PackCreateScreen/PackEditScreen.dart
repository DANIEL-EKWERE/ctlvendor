import 'package:ctlvendor/screens/PackCreateScreen/controller/PackCreateController.dart';
import 'package:ctlvendor/screens/PackListScreen/controller/PackListController.dart';
import 'package:ctlvendor/screens/PackListScreen/models/model.dart';
import 'package:ctlvendor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
//import 'package:get/get.dart';

//PackCreateController controller = Get.put(PackCreateController());

class PackEditScreen extends StatefulWidget {
  PackEditScreen(this.controller, this.product, {super.key});
  Data product;
  final PackCreateController controller;

  @override
  State<PackEditScreen> createState() => _PackEditScreenState();
}

class _PackEditScreenState extends State<PackEditScreen> {
  PackListController controllerx = Get.find<PackListController>();
  @override
  initState() {
    super.initState();
    widget.controller.editPackNameController.text = widget.product.name!;
    widget.controller.editPriceModifierController.text = widget.product.price!;
  }

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
                Text(
                  'Edit Pack',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
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
              controller: widget.controller.editPackNameController,
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
              controller: widget.controller.editPriceModifierController,
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
                      widget.controller.editPacks(widget.product.id.toString());
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
