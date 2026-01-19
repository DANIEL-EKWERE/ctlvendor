import 'package:ctlvendor/screens/ProductEditScreen/controller/ProductEditController.dart';
import 'package:get/get.dart';

class ProductEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ProductEditController());
  }
}
