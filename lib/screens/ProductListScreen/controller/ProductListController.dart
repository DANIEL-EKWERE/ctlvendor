import 'package:ctlvendor/screens/ProductListScreen/model/model.dart';
import 'package:get/get.dart';

class Productlistcontroller extends GetxController {
  Rx<bool> isLoading = false.obs;

  List<Product> products = <Product>[
    Product(
      name: 'sugar',
      categoryId: '1',
      cost: 20,
      createdAt: 'Today',
      description: 'this is a demo desc',
      id: 1,
      isActive: true,
      packId: '2',
      price: 20,
      sku: 'sku',
      stock: 20,
    ),
  ];

  Future<void> deleteProduct(int id) async {}
}
