import 'package:ctlvendor/screens/CategoryListScreen/controller/CategoryListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CategoryListController controller = Get.put(CategoryListController());

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({super.key});

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
