import 'package:ctlvendor/screens/OrderListScreen/controller/OrderListController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

OrderListController controller = Get.put(OrderListController());

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
