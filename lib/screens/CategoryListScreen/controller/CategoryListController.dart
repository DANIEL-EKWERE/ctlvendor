import 'package:ctlvendor/screens/CategoryListScreen/models/model.dart';
import 'package:get/get.dart';

class CategoryListController extends GetxController {
  Rx<bool> isLoading = false.obs;
  List<String> header = [
    'Name',
    "Description",
    'Product Count',
    'Status',
    'Action',
  ];

  List<Category> categories = <Category>[
    Category(
      name: 'Beverages',
      description: 'Soft drinks and juices',
      productsCount: 12,
      isActive: true,
    ),
    Category(
      name: 'Snacks',
      description: 'Chips, nuts, and more',
      productsCount: 18,
      isActive: true,
    ),

    Category(
      name: 'Dairy',
      description: 'Milk and dairy products',
      productsCount: 2,
      isActive: true,
    ),
    Category(
      name: 'Bakery',
      description: 'Bread and baked goods',
      productsCount: 15,
      isActive: true,
    ),

    Category(
      name: 'Beverages',
      description: 'Soft drinks and juices',
      productsCount: 12,
      isActive: true,
    ),
    Category(
      name: 'Snacks',
      description: 'Chips, nuts, and more',
      productsCount: 18,
      isActive: true,
    ),
  ];

  Future<void> deleteProduct(int id) async {}
}
