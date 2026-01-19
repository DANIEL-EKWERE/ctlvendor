import 'package:ctlvendor/screens/PromotionCreateScreen/controller/PromotionCreateController.dart';
import 'package:get/get.dart';

class PromotionCreateBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromotionCreateController());
  }
}
