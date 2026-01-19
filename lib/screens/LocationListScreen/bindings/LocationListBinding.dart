import 'package:ctlvendor/screens/LocationListScreen/controller/LocationListController.dart';
import 'package:get/get.dart';

class LocationListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationListController());
  }
}
