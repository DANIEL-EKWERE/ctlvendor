import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:ctlvendor/screens/dashboard_screen/controller/dashboard_controller.dart';

class DashboardBindings extends Bindings {
  @override
  void dependencies() {
    // Lazy loading the DashboardController
    Get.lazyPut(() => DashboardController());
  }
}
