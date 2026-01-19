import 'package:ctlvendor/screens/PackListScreen/controller/PackListController.dart';
import 'package:get/get.dart';

class PackListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackListController());
  }
}
