import 'package:ctlvendor/screens/ProductEditScreen/controller/ProductEditController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ProductEditController controller = Get.put(ProductEditController());

class ProductEditScreen extends StatefulWidget {
  const ProductEditScreen({super.key});

  @override
  State<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _ProductEditScreenState extends State<ProductEditScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
