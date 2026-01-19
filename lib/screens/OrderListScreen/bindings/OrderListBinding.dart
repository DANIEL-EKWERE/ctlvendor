import 'package:ctlvendor/screens/OrderListScreen/controller/OrderListController.dart';
import 'package:get/get.dart';

class OrderListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderListController());
  }
}
