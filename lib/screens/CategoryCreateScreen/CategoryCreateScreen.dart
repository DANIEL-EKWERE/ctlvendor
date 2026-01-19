import 'package:ctlvendor/screens/CategoryCreateScreen/controller/CategoryCreateController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CategoryCreateController controller = Get.put(CategoryCreateController());

class CategoryCreateScreen extends StatefulWidget {
  const CategoryCreateScreen({super.key});

  @override
  State<CategoryCreateScreen> createState() => _CategoryCreateScreenState();
}

class _CategoryCreateScreenState extends State<CategoryCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
