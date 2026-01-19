import 'package:ctlvendor/screens/PackCreateScreen/controller/PackCreateController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PackCreateController controller = Get.put(PackCreateController());

class PackCreateScreen extends StatefulWidget {
  const PackCreateScreen({super.key});

  @override
  State<PackCreateScreen> createState() => _PackCreateScreenState();
}

class _PackCreateScreenState extends State<PackCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
