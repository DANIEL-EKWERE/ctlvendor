import 'package:ctlvendor/screens/addLocation.dart/controller/addLocationController.dart';
import 'package:get/get.dart';

class Addlocationbinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddLocationcontroller>(() => AddLocationcontroller());
  }
}