import 'package:get/get.dart';
import 'package:ctlvendor/screens/vendor_business/model/vendor_business_model.dart';
import 'package:ctlvendor/screens/business_screen/controller/business_controller.dart';

class VendorBusinessController extends GetxController {
  Rx<VendorBusinessModel?> model = Rx<VendorBusinessModel?>(null);

  @override
  void onInit() {
    super.onInit();
    final arg = Get.arguments;
    if (arg is VendorBusinessModel) {
      model.value = arg;
    } else if (arg is BusinessController) {
      model.value = VendorBusinessModel.fromBusinessController(arg);
    }
  }

  void loadFromBusinessController(BusinessController bc) {
    model.value = VendorBusinessModel.fromBusinessController(bc);
  }
}
