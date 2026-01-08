import 'package:get/get.dart';
import 'package:ctlvendor/screens/summary_screen/controller/summary_controller.dart';

class SummaryBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SummaryController());
  }
}
