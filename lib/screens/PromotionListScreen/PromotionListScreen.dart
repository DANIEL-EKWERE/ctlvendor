import 'package:ctlvendor/screens/PromotionListScreen/controller/PromotionListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

PromotionListController controller = Get.put(PromotionListController());

class PromotionListScreen extends StatefulWidget {
  const PromotionListScreen({super.key});

  @override
  State<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
