import 'package:ctlvendor/screens/CategoryCreateScreen/controller/CategoryCreateController.dart';
import 'package:get/get.dart';

class CategoryCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryCreateController());
  }
}
