import 'package:get/get.dart';
import 'package:ctlvendor/screens/wallet_screen/controller/wallet_controller.dart';

class WalletBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => WalletController());
  }
}
