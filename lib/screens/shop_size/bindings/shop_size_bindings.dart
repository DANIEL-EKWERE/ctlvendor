import 'package:get/get.dart';
import 'package:ctlvendor/screens/shop_size/controller/shop_size_controller.dart';

class ShopSizeBindings extends Bindings {
  @override
  void dependencies() {
    // Add your controller dependencies here
    Get.lazyPut(() => ShopSizeController());
  }
}
