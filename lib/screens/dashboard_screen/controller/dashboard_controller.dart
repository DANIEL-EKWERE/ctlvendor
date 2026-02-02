// lib/controllers/dashboard_controller.dart
import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/dashboard_screen/models/models.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

class DashboardController extends GetxController {
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));

  DashboardModel dashboardModel = DashboardModel();

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

      // // Simulate API call
      // await Future.delayed(Duration(seconds: 1));

      // // Mock data
      // salesToday.value = 25000.00;
      // ordersToday.value = 45;
      // totalProducts.value = 150;
      // activePromotions.value = 5;
      // lowStockCount.value = 12;
      // pendingOrders.value = 8;

      // topProducts.value = [
      //   {
      //     'name': 'Product A',
      //     'sold': 50,
      //     'revenue': 15000,
      //     'categoryName': 'Beveragies',
      //   },
      //   {
      //     'name': 'Product B',
      //     'sold': 35,
      //     'revenue': 10500,
      //     'categoryName': 'Dairy',
      //   },
      //   {
      //     'name': 'Product C',
      //     'sold': 28,
      //     'revenue': 8400,
      //     'categoryName': 'Snacks',
      //   },
      //   {
      //     'name': 'Product D',
      //     'sold': 28,
      //     'revenue': 4260,
      //     'categoryName': 'Bakery',
      //   },
      // ];

      var response = await apiClient.getDashboardData();

      if (response.statusCode == 200 || response.statusCode == 201) {
        dashboardModel = dashboardModelFromJson(response.body);
        isLoading.value = false;
        salesToday.value = dashboardModel.salesToday?.toDouble() ?? 0.0;
        ordersToday.value = dashboardModel.ordersToday ?? 0;
        totalProducts.value = dashboardModel.totalProducts ?? 0;
        activePromotions.value = dashboardModel.activePromotions ?? 0;
        lowStockCount.value = dashboardModel.lowStockAlert ?? 0;
        pendingOrders.value = dashboardModel.pendingOrders ?? 0;

        topProducts.value =
            dashboardModel.topSellingProducts?.map((product) {
              return {
                'name': product.name ?? 'N/A',
                'sold': product.soldCount ?? 0,
                'revenue': product.revenue ?? 0.0,
              };
            }).toList() ??
            [];
      } else {
        Get.snackbar('Error', 'Failed to load dashboard data');
        isLoading.value = false;
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to load dashboard data');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshDashboard() async {
    await loadDashboardData();
  }
}
