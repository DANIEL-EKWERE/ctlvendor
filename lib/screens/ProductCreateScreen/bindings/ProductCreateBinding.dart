import 'package:ctlvendor/screens/ProductCreateScreen/controller/ProductCreateController.dart';
import 'package:get/get.dart';

class ProductCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductCreateController());
  }
}
