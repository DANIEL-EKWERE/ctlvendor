import 'package:ctlvendor/screens/operation/controller/operation_controller.dart';
import 'package:get/get.dart';

class OperationsBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperationController>(() => OperationController());
  }
}