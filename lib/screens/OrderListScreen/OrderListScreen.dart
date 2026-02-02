import 'package:ctlvendor/routes/app_routes.dart';
import 'package:ctlvendor/screens/OrderListScreen/controller/OrderListController.dart';
import 'package:ctlvendor/screens/profile_screen/controller/profile_controller.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

ProfileController controller1 = Get.put(ProfileController());
OrderListController controller = Get.put(OrderListController());

class OrderListScreen extends StatefulWidget {
  const OrderListScreen({super.key});

  @override
  State<OrderListScreen> createState() => _OrderListScreenState();
}

class _OrderListScreenState extends State<OrderListScreen> {
  final TextEditingController searchController = TextEditingController();

  String firstName = 'N/A';
  String lastName = '';
  @override
  initState() {
    super.initState();
    setValue();
  }

  setValue() async {
    var fname = await dataBase.getFirstName();
    var lname = await dataBase.getLastName();
    setState(() {
      firstName = fname;
      lastName = lname;
    });
    // myLog.log('first name $fname ans last name $lastName');
  }

  Widget _buildDrawer() {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF004DBF)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 30, color: Color(0xFF004DBF)),
                ),
                SizedBox(height: 12),
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                // Text(
                //   'vendor@email.com',
                //   style: TextStyle(color: Colors.white70, fontSize: 14),
                // ),
              ],
            ),
          ),
          _buildDrawerItem(
            Icons.dashboard_customize_outlined,
            'Dashboard',
            () => Get.toNamed(AppRoutes.dashboard),
          ),
          _buildDrawerItem(
            Icons.shopping_bag_outlined,
            'Orders',
            () => Get.back(),
          ),
          _buildDrawerItem(
            Icons.inventory_2_outlined,
            'Products',
            () => Get.toNamed(AppRoutes.productList),
          ),
          // _buildDrawerItem(
          //   Icons.category_outlined,
          //   'Categories',
          //   () => Get.toNamed(AppRoutes.categoryList),
          // ),
          _buildDrawerItem(
            Icons.inventory_2_outlined,
            'Packs',
            () => Get.toNamed(AppRoutes.packList),
          ),
          _buildDrawerItem(
            Icons.local_offer_outlined,
            'Promotions',
            () => Get.toNamed(AppRoutes.promotionList),
          ),
          _buildDrawerItem(
            Icons.location_on_outlined,
            'Locations',
            () => Get.toNamed(AppRoutes.locationList),
          ),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Profile', () {}),
          _buildDrawerItem(Icons.logout, 'Logout', () {
            Get.dialog(
              AlertDialog(
                content: SizedBox(
                  height: 180,
                  child: Column(
                    children: [
                      Icon(Icons.logout, size: 40, color: Colors.red),
                      Text(
                        'Logout Confirmation',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Are you sure you want to logout?'),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () => Get.back(),
                            child: Text('Cancel'),
                          ),
                          SizedBox(width: 10),
                          SizedBox(
                            height: 40,
                            width: 110,
                            child: ElevatedButton(
                              onPressed: () async {
                                controller1.logOut();
                              },
                              child: Text('Logout'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
          Divider(),
          SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8.0),
            child: Text('version 1.1'),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      drawer: _buildDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.grey.shade50,
        elevation: 0,

        // leading: IconButton(
        //   icon: Icon(Icons.menu, color: Colors.black),
        //   onPressed: () => Scaffold.of(context).openDrawer(),
        // ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Orders',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 4),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .50,
                      child: Text(
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        'Manage Orders in one go',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  width: 140,
                  child: ElevatedButton.icon(
                    onPressed: () => Get.toNamed(AppRoutes.productCreate),
                    icon: Icon(Icons.add, size: 18),
                    label: Text('Add Order', style: TextStyle(fontSize: 12)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white,
                      // padding: EdgeInsets.symmetric(
                      //   horizontal: 20,
                      //   vertical: 12,
                      // ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Table(
          //   children: [

          //   ],
          // ),
          //DataTable(columns: [], rows: []),

          // Search Bar
          Expanded(
            child: Container(
              margin: EdgeInsets.all(12),
              padding: EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(width: 1, color: Colors.black12),
              ),
              child: Column(
                children: [
                  TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: 'Search order by name or SKU',
                      hintStyle: TextStyle(
                        color: Colors.grey[400],
                        fontSize: 14,
                      ),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.grey[50],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey[200]!),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.black),
                      ),
                    ),
                  ),

                  const SizedBox(height: 20),

                  /// ================= CONTENT =================
                  Expanded(
                    child: Obx(() {
                      if (controller.isLoading.value) {
                        return const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        );
                      }

                      if (controller.orders.isEmpty) {
                        return Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.inventory_2_outlined,
                                size: 64,
                                color: Colors.grey[300],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'No products yet',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.grey[600],
                                ),
                              ),
                              SizedBox(height: 8),
                              TextButton(
                                onPressed: () =>
                                    Get.toNamed(AppRoutes.productCreate),
                                child: Text('Add your first product'),
                              ),
                            ],
                          ),
                        );
                      }

                      /// ================= TABLE =================
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Table(
                            columnWidths: const {
                              0: FixedColumnWidth(120),
                              1: FixedColumnWidth(140),
                              2: FixedColumnWidth(100),
                              3: FixedColumnWidth(100),
                              4: FixedColumnWidth(140),
                              5: FixedColumnWidth(100),
                              6: FixedColumnWidth(60),
                              7: FixedColumnWidth(160),
                              // 8: FixedColumnWidth(80),
                            },
                            border: TableBorder(
                              horizontalInside: BorderSide(
                                color: Colors.grey.shade200,
                              ),
                            ),
                            children: [
                              /// HEADER
                              TableRow(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade100,
                                ),
                                children: [
                                  _headerCell('Order Number'),
                                  _headerCell('Customer Name'),
                                  _headerCell('Date'),
                                  _headerCell('Total'),
                                  _headerCell('Payment Method'),
                                  _headerCell('Status'),

                                  _headerCell(''),
                                  _headerCell('Action'),
                                ],
                              ),

                              /// DATA
                              ...controller.orders.map(
                                (product) => TableRow(
                                  children: [
                                    _cell(product.orderNumber),
                                    _cell(product.customerName),
                                    _cell(product.date),
                                    _cell(product.total.toString()),
                                    _cell(product.paymentMethod),
                                    product.status == 'pending'
                                        ? Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.yellow.shade100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                product.status!,
                                                style: TextStyle(
                                                  color: Colors.yellow,
                                                ),
                                              ),
                                            ),
                                          )
                                        : product.status == 'confirmed'
                                        ? Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.blue.shade100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                product.status!,
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(
                                            margin: EdgeInsets.all(10),
                                            padding: EdgeInsets.all(5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              color: Colors.green.shade100,
                                            ),
                                            child: Center(
                                              child: Text(
                                                product.status!,
                                                style: TextStyle(
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ),
                                          ),

                                    // _menuCell(product),
                                    IconButton(
                                      icon: Icon(Icons.edit, color: Colors.red),
                                      onPressed: () {},
                                      color: Colors.red,
                                    ),

                                    //_cell('Deactivate'),
                                    IconButton(
                                      icon: Icon(Icons.delete_outline),
                                      onPressed: () {},
                                      color: Colors.red,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),
          ),

          // Table Content
        ],
      ),
    );
  }

  Widget _headerCell(String text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text,
        style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13),
      ),
    );
  }

  Widget _cell(String? text) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Text(
        text ?? '',
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    );
  }

  Widget _menuCell(product) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: PopupMenuButton(
        icon: Icon(Icons.more_horiz),
        itemBuilder: (_) => [],
      ),
    );
  }
}
