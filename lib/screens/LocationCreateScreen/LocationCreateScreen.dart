import 'package:ctlvendor/screens/LocationCreateScreen/controller/LocationCreateController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

LocationCreateController controller = Get.put(LocationCreateController());

class LocationCreateScreen extends StatefulWidget {
  const LocationCreateScreen({super.key});

  @override
  State<LocationCreateScreen> createState() => _LocationCreateScreenState();
}

class _LocationCreateScreenState extends State<LocationCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
