import 'dart:convert';

import 'package:ctlvendor/data/apiClient/apiClient.dart';
import 'package:ctlvendor/screens/OrderDetailsScreen/models/model.dart';
import 'package:ctlvendor/screens/orders_screen/models/accepted_order.dart';
import 'package:ctlvendor/screens/orders_screen/models/models.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

class OrderListController extends GetxController {
  ApiClient apiClient = ApiClient(Duration(seconds: 60 * 5));

  OrderModel orderModel = OrderModel();
  AcceptedOrderModel acceptedOrderModel = AcceptedOrderModel();
  RxList<Data> availableData = <Data>[].obs;

  RxList<Data> orders = <Data>[].obs;

  RxList<AcceptedData> acceptedData = <AcceptedData>[].obs;

  RxBool isLoading = false.obs;

  //RxBool isLoadingOrders = false.obs;
  RxBool isloadingAccpted = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchOrderByCondition();
    fetchAcceptedOrderByCondition();
  }

  fetchOrderByCondition() {
    if (orders.isNotEmpty) return;
    fetchOrders();
  }

  fetchAcceptedOrderByCondition() {
    if (acceptedData.isNotEmpty) return;
    fetchAcceptedOrders();
  }

  Future<void> fetchOrders() async {
    isLoading.value = true;
    try {
      var response = await apiClient.fetchAllOrders();

      if (response.statusCode == 201 || response.statusCode == 200) {
        isLoading.value = false;
        myLog.log('Response: ${response.body}');
        myLog.log('Status Code: ${response.statusCode}');
        orderModel = orderModelFromJson(response.body);
        orders.value = orderModel.data!;
      } else {
        isLoading.value = false;
        Get.snackbar('Something Went Wrong', jsonDecode(response.body));
        myLog.log(jsonDecode(response.body));
      }
    } catch (e) {
      isLoading.value = false;
      Get.snackbar('Error', e.toString());
      myLog.log(e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchAcceptedOrders() async {
    isloadingAccpted.value = true;
    try {
      var response = await apiClient.fetchAcceptedOrders();

      if (response.statusCode == 201 || response.statusCode == 200) {
        isloadingAccpted.value = false;
        acceptedOrderModel = acceptedOrderModelFromJson(response.body);
        acceptedData.value = acceptedOrderModel.data!;
      } else {
        isloadingAccpted.value = false;
        Get.snackbar('Something Went Wrong', jsonDecode(response.body));
        myLog.log(jsonDecode(response.body));
      }
    } catch (e) {
      myLog.log("ERROR ${e}");
      isloadingAccpted.value = false;
      Get.snackbar('Error', e.toString());
      myLog.log(e.toString());
    } finally {
      isloadingAccpted.value = false;
    }
  }

  Future<void> deleteProduct(int id) async {}
}
