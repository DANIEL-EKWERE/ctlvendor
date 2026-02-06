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
    controller.fetchOrders();
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
                // SizedBox(
                //   width: 140,
                //   child: ElevatedButton.icon(
                //     onPressed: () => Get.toNamed(AppRoutes.productCreate),
                //     icon: Icon(Icons.add, size: 18),
                //     label: Text('Add Order', style: TextStyle(fontSize: 12)),
                //     style: ElevatedButton.styleFrom(
                //       backgroundColor: Colors.black,
                //       foregroundColor: Colors.white,
                //       // padding: EdgeInsets.symmetric(
                //       //   horizontal: 20,
                //       //   vertical: 12,
                //       // ),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //     ),
                //   ),
                // ),
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
                          child: CircularProgressIndicator(color: Color(0xFF004DBF)),
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
                                child: Text(
                                  'Add your first product to start receiving orders',
                                ),
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
                                0: FixedColumnWidth(150),
                                1: FixedColumnWidth(130),
                                2: FixedColumnWidth(100),
                                3: FixedColumnWidth(130),
                                4: FixedColumnWidth(130),
                                5: FixedColumnWidth(150),
                                6: FixedColumnWidth(60),
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
                                    _headerCell(
                                      'Order #',
                                      icon: Icons.receipt_long,
                                    ),
                                    _headerCell('Customer', icon: Icons.person),
                                    _headerCell(
                                      'Date',
                                      icon: Icons.calendar_today,
                                    ),
                                    _headerCell(
                                      'Amount',
                                      icon: Icons.attach_money,
                                    ),
                                    _headerCell(
                                      'Payment',
                                      icon: Icons.credit_card,
                                    ),
                                    _headerCell('Status', icon: Icons.info),
                                    _headerCell(''),
                                    _headerCell('Action', icon: Icons.settings),
                                  ],
                                ),

                                /// DATA
                                ...controller.orders.asMap().entries.map((
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
                                      _dataCell(product.reference ?? 'N/A'),
                                      _dataCell(
                                        product.customer!.name ?? 'Unknown',
                                      ),
                                      _dataCell(_formatDate(product.createdAt)),
                                      _amountCell(
                                        '\$${_formatAmount(product.total)}',
                                      ),
                                      _paymentCell(product.isPaid == true),
                                      _statusBadge(product.status),
                                      SizedBox(),
                                      _actionCell(onDelete: () {}),
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

  Widget _amountCell(String amount) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      child: Text(
        amount,
        style: TextStyle(
          fontSize: 13.5,
          fontWeight: FontWeight.w700,
          color: Color(0xFF004DBF),
        ),
      ),
    );
  }

  Widget _paymentCell(bool isPaid) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
        decoration: BoxDecoration(
          color: isPaid ? Colors.green.shade50 : Colors.orange.shade50,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
            color: isPaid ? Colors.green.shade300 : Colors.orange.shade300,
            width: 0.8,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isPaid ? Icons.check_circle : Icons.pending_actions,
              size: 14,
              color: isPaid ? Colors.green.shade700 : Colors.orange.shade700,
            ),
            SizedBox(width: 5),
            Text(
              isPaid ? 'Paid' : 'Pending',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: isPaid ? Colors.green.shade700 : Colors.orange.shade700,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _actionCell({required VoidCallback onDelete}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      child: Container(
        alignment: Alignment.center,
        child: Tooltip(
          message: 'Delete Order',
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onDelete,
              borderRadius: BorderRadius.circular(6),
              child: Container(
                padding: EdgeInsets.all(6),
                child: Icon(
                  Icons.delete_outline,
                  size: 18,
                  color: Colors.red.shade500,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _formatDate(String? date) {
    if (date == null || date.isEmpty) return 'N/A';
    try {
      final parsedDate = DateTime.parse(date);
      return '${parsedDate.day}/${parsedDate.month}/${parsedDate.year}';
    } catch (e) {
      return date;
    }
  }

  String _formatAmount(dynamic amount) {
    if (amount == null) return '0.00';
    try {
      final value = double.parse(amount.toString());
      return value.toStringAsFixed(2);
    } catch (e) {
      return '0.00';
    }
  }

  Widget _statusBadge(String? status) {
    late Color backgroundColor;
    late Color textColor;
    late Color borderColor;
    late IconData icon;

    switch (status?.toLowerCase()) {
      case 'pending':
        backgroundColor = Colors.amber.shade50;
        textColor = Colors.amber.shade700;
        borderColor = Colors.amber.shade300;
        icon = Icons.schedule;
        break;
      case 'accepted':
        backgroundColor = Colors.blue.shade50;
        textColor = Colors.blue.shade700;
        borderColor = Colors.blue.shade300;
        icon = Icons.thumb_up;
        break;
      case 'confirmed':
        backgroundColor = Colors.green.shade50;
        textColor = Colors.green.shade700;
        borderColor = Colors.green.shade300;
        icon = Icons.verified;
        break;
      default:
        backgroundColor = Colors.red.shade50;
        textColor = Colors.red.shade700;
        borderColor = Colors.red.shade300;
        icon = Icons.cancel;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
          boxShadow: [
            BoxShadow(
              color: textColor.withOpacity(0.08),
              blurRadius: 3,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: textColor),
            SizedBox(width: 6),
            Text(
              (status ?? 'Unknown').toUpperCase(),
              style: TextStyle(
                color: textColor,
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
