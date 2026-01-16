// lib/controllers/dashboard_controller.dart
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs;
  var salesToday = 0.0.obs;
  var ordersToday = 0.obs;
  var totalProducts = 0.obs;
  var activePromotions = 0.obs;
  var lowStockCount = 0.obs;
  var pendingOrders = 0.obs;
  var topProducts = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadDashboardData();
  }

  Future<void> loadDashboardData() async {
    try {
      isLoading.value = true;
      
      // Simulate API call
      await Future.delayed(Duration(seconds: 1));
      
      // Mock data
      salesToday.value = 25000.00;
      ordersToday.value = 45;
      totalProducts.value = 150;
      activePromotions.value = 5;
      lowStockCount.value = 12;
      pendingOrders.value = 8;
      
      topProducts.value = [
        {'name': 'Product A', 'sold': 50, 'revenue': 15000},
        {'name': 'Product B', 'sold': 35, 'revenue': 10500},
        {'name': 'Product C', 'sold': 28, 'revenue': 8400},
      ];
      
    } catch (e) {
      Get.snackbar('Error', 'Failed to load dashboard data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }
}