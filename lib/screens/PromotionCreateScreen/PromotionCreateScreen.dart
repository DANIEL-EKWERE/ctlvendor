import 'package:ctlvendor/screens/PromotionCreateScreen/controller/PromotionCreateController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PromotionCreateController controller = Get.put(PromotionCreateController());

class PromotionCreateScreen extends StatefulWidget {
  const PromotionCreateScreen({super.key});

  @override
  State<PromotionCreateScreen> createState() => _PromotionCreateScreenState();
}

class _PromotionCreateScreenState extends State<PromotionCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
