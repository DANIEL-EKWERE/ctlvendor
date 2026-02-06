import 'package:ctlvendor/routes/app_routes.dart';
import 'package:ctlvendor/screens/PromotionCreateScreen/PromotionCreateScreen.dart';
import 'package:ctlvendor/screens/PromotionCreateScreen/PromotionEditScreen.dart';
import 'package:ctlvendor/screens/PromotionCreateScreen/controller/PromotionCreateController.dart';
import 'package:ctlvendor/screens/PromotionListScreen/controller/PromotionListController.dart';
import 'package:ctlvendor/screens/profile_screen/controller/profile_controller.dart';
import 'package:ctlvendor/utils/storage.dart';
import 'package:ctlvendor/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

ProfileController controller1 = Get.put(ProfileController());
PromotionListController controller = Get.put(PromotionListController());

class PromotionListScreen extends StatefulWidget {
  const PromotionListScreen({super.key});

  @override
  State<PromotionListScreen> createState() => _PromotionListScreenState();
}

class _PromotionListScreenState extends State<PromotionListScreen> {
  final TextEditingController searchController = TextEditingController();

  _onRefresh() {
    controller.fetchPromotions();
  }

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
            () => Get.toNamed(AppRoutes.orderList),
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
            () => Get.back(),
          ),
          _buildDrawerItem(
            Icons.location_on_outlined,
            'Locations',
            () => Get.toNamed(AppRoutes.locationList),
          ),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Settings', () {}),
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
          SizedBox(height: 20),
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
    return RefreshIndicator(
      onRefresh: controller.fetchPromotions,

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
                        'Promotions',
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
                          'Manage your promotions here',
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
                      onPressed: () {
                        Get.dialog(
                          AlertDialog(
                            backgroundColor: Colors.transparent,
                            insetPadding: EdgeInsets.zero,
                            contentPadding: EdgeInsets.zero,

                            content: SizedBox(
                              height: 650,
                              width: 300,
                              child: PromotionCreateScreen(
                                Get.put(PromotionCreateController()),
                              ),
                            ),
                          ),
                        );
                      },
                      //=> Get.toNamed(AppRoutes.promotionCreate),
                      icon: Icon(Icons.add, size: 18),
                      label: Text(
                        'Add Promotion',
                        style: TextStyle(fontSize: 12),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF004DBF),
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
                              color: Color(0xFF004DBF),
                            ),
                          );
                        }

                        if (controller.promotions.isEmpty) {
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
                                  onPressed: () {
                                    Get.dialog(
                                      AlertDialog(
                                        backgroundColor: Colors.transparent,
                                        insetPadding: EdgeInsets.zero,
                                        contentPadding: EdgeInsets.zero,

                                        content: SizedBox(
                                          height: 650,
                                          width: 300,
                                          child: PromotionCreateScreen(
                                            Get.put(
                                              PromotionCreateController(),
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                  //=>

                                  //  Get.toNamed(AppRoutes.productCreate),
                                  child: Text('Add your first promotion'),
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
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Table(
                                columnWidths: const {
                                  0: FixedColumnWidth(130),
                                  1: FixedColumnWidth(130),
                                  2: FixedColumnWidth(110),
                                  3: FixedColumnWidth(200),
                                  4: FixedColumnWidth(100),
                                  5: FixedColumnWidth(120),
                                  6: FixedColumnWidth(80),
                                  7: FixedColumnWidth(100),
                                },
                                border: TableBorder(
                                  top: BorderSide(
                                    color: Color(0xFF004DBF),
                                    width: 2,
                                  ),
                                  bottom: BorderSide(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                  horizontalInside: BorderSide(
                                    color: Colors.grey.shade100,
                                    width: 0.6,
                                  ),
                                ),
                                children: [
                                  /// HEADER
                                  TableRow(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          Color(0xFF004DBF),
                                          Color(0xFF0056D2),
                                        ],
                                        begin: Alignment.topLeft,
                                        end: Alignment.bottomRight,
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.08),
                                          blurRadius: 4,
                                          offset: Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      _headerCell('Image', icon: Icons.image),
                                      _headerCell(
                                        'Title',
                                        icon: Icons.local_offer,
                                      ),
                                      _headerCell(
                                        'Discount',
                                        icon: Icons.percent,
                                      ),
                                      _headerCell(
                                        'Date Range',
                                        icon: Icons.date_range,
                                      ),
                                      _headerCell(
                                        'Products',
                                        icon: Icons.inventory,
                                      ),
                                      _headerCell('Status', icon: Icons.info),
                                      _headerCell('Edit', icon: Icons.edit),
                                      _headerCell(
                                        'Action',
                                        icon: Icons.settings,
                                      ),
                                    ],
                                  ),

                                  /// DATA
                                  ...controller.promotions.asMap().entries.map((
                                    entry,
                                  ) {
                                    final index = entry.key;
                                    final product = entry.value;
                                    final isEvenRow = index.isEven;
                                    return TableRow(
                                      decoration: BoxDecoration(
                                        color: isEvenRow
                                            ? Colors.white
                                            : Colors.grey.shade50,
                                        border: Border(
                                          bottom: BorderSide(
                                            color: Colors.grey.shade100,
                                            width: 0.5,
                                          ),
                                        ),
                                      ),
                                      children: [
                                        CustomImageView(
                                          fit: BoxFit.cover,
                                          height: 50,
                                          width: 20,
                                          imagePath: product.imageUrl,
                                        ),
                                        _dataCell(product.title!),
                                        _discountCell(product.discount!),
                                        _dataCell(
                                          "${DateFormat('MMM dd, yyyy').format(DateTime.parse(product.startsAt!))} - ${DateFormat('MMM dd, yyyy').format(DateTime.parse(product.endsAt!))}",
                                        ),
                                        _dataCell(
                                          '${product.vendorProducts!.length} items',
                                        ),
                                        _statusBadgePromotion(true),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Tooltip(
                                            message: 'Edit Promotion',
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  Get.dialog(
                                                    AlertDialog(
                                                      backgroundColor:
                                                          Colors.transparent,
                                                      insetPadding:
                                                          EdgeInsets.zero,
                                                      contentPadding:
                                                          EdgeInsets.zero,
                                                      content: SizedBox(
                                                        height: 650,
                                                        width: 300,
                                                        child: PromotionEditScreen(
                                                          product,
                                                          Get.put(
                                                            PromotionCreateController(),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  child: Icon(
                                                    Icons.edit_outlined,
                                                    size: 18,
                                                    color: Colors.blue.shade600,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          alignment: Alignment.center,
                                          child: Tooltip(
                                            message: 'Delete Promotion',
                                            child: Material(
                                              color: Colors.transparent,
                                              child: InkWell(
                                                onTap: () {
                                                  
                                                },
                                                borderRadius:
                                                    BorderRadius.circular(6),
                                                child: Container(
                                                  padding: EdgeInsets.all(6),
                                                  child: Text('Deactivate'),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  }),
                                ],
                              ),
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

  Widget _headerCell(String text, {IconData? icon}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: Colors.white70),
            SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
                color: Colors.white,
                letterSpacing: 0.6,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataCell(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w500,
          color: Colors.grey.shade800,
          height: 1.4,
        ),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _discountCell(String discount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.purple.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.purple.shade300, width: 0.8),
        ),
        child: Center(
          child: Text(
            discount,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: Colors.purple.shade700,
            ),
          ),
        ),
      ),
    );
  }

  Widget _statusBadgePromotion(bool isActive) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: isActive ? Colors.green.shade50 : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isActive ? Colors.green.shade300 : Colors.grey.shade300,
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isActive
                  ? Colors.green.withOpacity(0.08)
                  : Colors.grey.withOpacity(0.08),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? Icons.check_circle : Icons.remove_circle_outline,
              size: 14,
              color: isActive ? Colors.green.shade700 : Colors.grey.shade700,
            ),
            SizedBox(width: 6),
            Text(
              isActive ? 'ACTIVE' : 'INACTIVE',
              style: TextStyle(
                color: isActive ? Colors.green.shade700 : Colors.grey.shade700,
                fontWeight: FontWeight.w700,
                fontSize: 11,
                letterSpacing: 0.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
