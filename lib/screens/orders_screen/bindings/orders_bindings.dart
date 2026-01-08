import 'package:get/get.dart';
import 'package:ctlvendor/screens/orders_screen/controller/orders_controller.dart';

class OrdersBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => OrdersController());
    // Uncomment the above line and replace with actual controller when implemented
  }
}
