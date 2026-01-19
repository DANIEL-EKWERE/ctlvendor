import 'package:ctlvendor/screens/OrderDetailsScreen/controller/OrderDetailsController.dart';
import 'package:get/get.dart';

class OrderDetailsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrderDetailsController());
  }
}
