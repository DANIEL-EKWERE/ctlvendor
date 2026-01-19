import 'package:ctlvendor/screens/LocationListScreen/controller/LocationListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

LocationListController controller = Get.put(LocationListController());

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
