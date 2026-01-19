import 'package:ctlvendor/screens/PackListScreen/controller/PackListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PackListController controller = Get.put(PackListController());

class PackListScreen extends StatefulWidget {
  const PackListScreen({super.key});

  @override
  State<PackListScreen> createState() => _PackListScreenState();
}

class _PackListScreenState extends State<PackListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
