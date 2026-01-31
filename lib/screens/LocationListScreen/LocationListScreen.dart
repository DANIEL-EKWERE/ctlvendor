import 'package:ctlvendor/routes/app_routes.dart';
import 'package:ctlvendor/screens/LocationCreateScreen/LocationCreateScreen.dart';
import 'package:ctlvendor/screens/LocationCreateScreen/LocationEditScreen.dart';
import 'package:ctlvendor/screens/LocationCreateScreen/controller/LocationCreateController.dart';
import 'package:ctlvendor/screens/LocationListScreen/controller/LocationListController.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

LocationListController controller = Get.put(LocationListController());

class LocationListScreen extends StatefulWidget {
  const LocationListScreen({super.key});

  @override
  State<LocationListScreen> createState() => _LocationListScreenState();
}

class _LocationListScreenState extends State<LocationListScreen> {
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
  //  myLog.log('first name $fname ans last name $lastName');
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
            () => Get.back(),
          ),
          _buildDrawerItem(
            Icons.shopping_bag_outlined,
            'Orders',
            () => Get.toNamed(AppRoutes.orderList),
          ),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Settings', () {}),
          _buildDrawerItem(Icons.logout, 'Logout', () {}),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: controller.fetchLocations,
      child: Scaffold(
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
                        'Locations',
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
                          'Manage warehouses and delivery locations Add Location',
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
                      // onPressed: ()
                      //  => Get.toNamed(AppRoutes.productCreate),
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,
                            content: SizedBox(
                              height: 500,
                              child: LocationCreateScreen(),
                            ),
                          ),
                        );
                      },
                      icon: Icon(Icons.add, size: 18),
                      label: Text(
                        'Add Location',
                        style: TextStyle(fontSize: 12),
                      ),
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
                        hintText: 'Search products by name or SKU',
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
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }

                        if (controller.locations.isEmpty) {
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
                                  'No location yet',
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 8),
                                TextButton(
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,
                                        content: SizedBox(
                                          height: 500,
                                          child: LocationCreateScreen(),
                                        ),
                                      ),
                                    );
                                  },
                                  //() =>
                                  //      Get.toNamed(AppRoutes.productCreate),
                                  child: Text('Add your first location'),
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
                                1: FixedColumnWidth(100),
                                2: FixedColumnWidth(100),
                                3: FixedColumnWidth(180),
                                4: FixedColumnWidth(180),
                                5: FixedColumnWidth(100),
                                6: FixedColumnWidth(80),
                                7: FixedColumnWidth(80),
                                // 7: FixedColumnWidth(100),
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
                                    _headerCell('City'),
                                    _headerCell('State'),
                                    _headerCell('Country'),
                                    _headerCell('Phone'),
                                    _headerCell('Contact Address'),
                                    _headerCell('Status'),

                                    _headerCell(''),
                                    _headerCell('Action'),
                                  ],
                                ),

                                /// DATA
                                ...controller.locations.map(
                                  (product) => TableRow(
                                    children: [
                                      _cell(product.lga ?? 'N/A'),
                                      _cell(product.state ?? 'N/A'),
                                      _cell(product.country ?? 'N/A'),
                                      _cell(product.phone ?? 'N/A'),
                                      _cell(product.contactAddress ?? 'N/A'),

                                      Container(
                                        margin: EdgeInsets.all(10),
                                        padding: EdgeInsets.all(5),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: Text(
                                            product.isActive == "1"
                                                ? 'Active'
                                                : 'In-Active',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // _menuCell(product),
                                      IconButton(
                                        icon: Icon(
                                          Icons.edit,
                                          color: Colors.red,
                                        ),
                                        onPressed: () {
                                          Get.dialog(
                                            AlertDialog(
                                              backgroundColor:
                                                  Colors.transparent,
                                              insetPadding: EdgeInsets.zero,
                                              contentPadding: EdgeInsets.zero,
                                              content: SizedBox(
                                                height: 500,
                                                child: LocationEditScreen(
                                                  Get.put(
                                                    LocationCreateController(),
                                                  ),
                                                  product,
                                                ),
                                              ),
                                            ),
                                          );
                                        },
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
