import 'package:ctlvendor/screens/plan/controller/plan_controller.dart';
import 'package:get/get.dart';

class PlanBinding extends Bindings {
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> PlanController());
  }

}