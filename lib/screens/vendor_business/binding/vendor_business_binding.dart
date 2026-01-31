import 'package:get/get.dart';
import 'package:ctlvendor/screens/vendor_business/controller/vendor_business_controller.dart';

class VendorBusinessBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<VendorBusinessController>(() => VendorBusinessController());
  }
}
