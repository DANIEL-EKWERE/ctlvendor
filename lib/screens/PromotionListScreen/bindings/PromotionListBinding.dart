import 'package:ctlvendor/screens/PromotionListScreen/controller/PromotionListController.dart';
import 'package:get/get.dart';

class PromotionListBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => PromotionListController());
  }
}
