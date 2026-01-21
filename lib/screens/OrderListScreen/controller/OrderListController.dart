import 'package:ctlvendor/screens/OrderDetailsScreen/models/model.dart';
import 'package:get/get.dart';

class OrderListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  List<String> header = [
    'Name',
    "Description",
    'Product Count',
    'Status',
    'Action',
  ];

  List<Order> orders = <Order>[
    Order(
      orderNumber: 'ORD-2026-001',
      customerName: 'John Doe',
      date: '18/01/2026',
      total: 45.97,
      paymentMethod: 'Credit Card',
      status: 'pending',
    ),
    Order(
      orderNumber: 'ORD-2026-002',
      customerName: 'Jane Smith',
      date: '18/01/2026',
      total: 28.95,
      paymentMethod: 'Cash',
      status: 'confirmed',
    ),
    Order(
      orderNumber: 'ORD-2026-003',
      customerName: 'Bob Johnson',
      date: '17/01/2026',
      total: 67.43,
      paymentMethod: 'Debit Card',
      status: 'delivered',
    ),
  ];

  Future<void> deleteProduct(int id) async {}
}
