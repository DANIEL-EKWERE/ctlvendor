import 'package:ctlvendor/screens/PackCreateScreen/controller/PackCreateController.dart';
import 'package:get/get.dart';

class PackCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PackCreateController());
  }
}
