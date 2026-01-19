import 'package:ctlvendor/screens/LocationCreateScreen/controller/LocationCreateController.dart';
import 'package:get/get.dart';

class LocationCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LocationCreateController());
  }
}
