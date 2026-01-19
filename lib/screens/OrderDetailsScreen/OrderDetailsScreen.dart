import 'package:ctlvendor/screens/OrderDetailsScreen/controller/OrderDetailsController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

OrderDetailsController controller = Get.put(OrderDetailsController());

class OrderDetailsScreen extends StatefulWidget {
  const OrderDetailsScreen({super.key});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
