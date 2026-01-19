import 'package:ctlvendor/screens/ProductListScreen/controller/ProductListController.dart';
import 'package:get/get.dart';

class Productlistbinding extends Bindings{
  @override
  void dependencies() {
    // TODO: implement dependencies
    Get.lazyPut(()=> Productlistcontroller());
  }

}