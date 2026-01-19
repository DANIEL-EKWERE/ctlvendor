import 'package:ctlvendor/screens/CategoryListScreen/controller/CategoryListController.dart';
import 'package:get/get.dart';

class CategoryListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CategoryListController());
  }
}
