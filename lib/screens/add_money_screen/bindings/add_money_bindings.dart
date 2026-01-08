import 'package:get/get.dart';
import 'package:ctlvendor/screens/add_money_screen/controller/add_money_controller.dart';

class AddMoneyBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddMoneyController());
  }
}
