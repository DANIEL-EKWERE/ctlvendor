import 'package:ctlvendor/routes/app_routes.dart';
import 'package:ctlvendor/screens/login/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:ctlvendor/screens/dashboard_screen/controller/dashboard_controller.dart';
import 'package:ctlvendor/utils/storage.dart';
import '../../widgets/status_bar.dart';
import '../orders_screen/orders_screen.dart';
import '../wallet_screen/wallet_screen.dart';
import '../profile_screen/profile_screen.dart';
import 'dart:developer' as myLog;

DashboardController controller = Get.put(DashboardController());

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  int _currentIndex = 0;
  String firstName = 'N/A';
  String lastName = '';

  late final List<Widget> _tabs;
  @override
  void initState() {
    super.initState();
    setValue();
    _tabs = [
      HomeTab(firstName: firstName, lastName: lastName),
      const OrdersTab(),
      const WalletTab(),
      const ProfileTab(),
    ];
    // controller.fetchDashboardData();
  }

  setValue() async {
    var fname = await dataBase.getFirstName();
    var lname = await dataBase.getLastName();
    setState(() {
      firstName = fname;
      lastName = lname;
    });
    myLog.log('first name $fname ans last name $lastName');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      body: SafeArea(child: _tabs[_currentIndex]),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        selectedItemColor: const Color(0xFF004DBF),
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/home_unselected.svg'),
            activeIcon: SvgPicture.asset('assets/home_selected.svg'),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/order_unselected.svg'),
            activeIcon: SvgPicture.asset('assets/order_selected.svg'),
            label: 'Orders',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet_outlined),
            label: 'Wallet',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset('assets/profile_unselected.svg'),
            activeIcon: SvgPicture.asset('assets/profile_selected.svg'),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  final String firstName;
  final String lastName;

  const HomeTab({super.key, required this.firstName, required this.lastName});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
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
    myLog.log('first name $fname ans last name $lastName');
  }

  // Widget build(BuildContext context) {
  //   return Column(
  //     children: [
  //       const StatusBar(),
  //       Padding(
  //         padding: const EdgeInsets.all(16.0),
  //         child: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Image.asset('assets/logo.png', height: 40),
  //             GestureDetector(
  //               onTap: () {
  //                 Navigator.pushNamed(context, '/earnings');
  //               },
  //               child: const Icon(
  //                 Icons.notifications_outlined,
  //                 size: 28,
  //                 color: Colors.grey,
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //       const SizedBox(height: 24),
  //       GestureDetector(
  //         onTap: () {
  //           Navigator.pushNamed(context, '/earnings');
  //         },
  //         child: Container(
  //           margin: const EdgeInsets.symmetric(horizontal: 16),
  //           padding: const EdgeInsets.all(16),
  //           decoration: BoxDecoration(
  //             color: Colors.white,
  //             borderRadius: BorderRadius.circular(12),
  //             boxShadow: [
  //               BoxShadow(
  //                 color: Colors.black.withAlpha(
  //                   13,
  //                 ), // Changed from withOpacity(0.05)
  //                 blurRadius: 10,
  //                 offset: const Offset(0, 5),
  //               ),
  //             ],
  //           ),
  //           child: Row(
  //             children: [
  //               Container(
  //                 width: 50,
  //                 height: 50,
  //                 decoration: BoxDecoration(
  //                   color: const Color(0xFFFFF3E0),
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: const Icon(
  //                   Icons.bar_chart,
  //                   color: Color(0xFF004DBF),
  //                   size: 30,
  //                 ),
  //               ),
  //               const SizedBox(width: 16),
  //               const Expanded(
  //                 child: Column(
  //                   crossAxisAlignment: CrossAxisAlignment.start,
  //                   children: [
  //                     Text(
  //                       'View Earnings',
  //                       style: TextStyle(
  //                         fontSize: 16,
  //                         fontWeight: FontWeight.bold,
  //                       ),
  //                     ),
  //                     SizedBox(height: 4),
  //                     Text(
  //                       'Check your daily and weekly earnings',
  //                       style: TextStyle(fontSize: 12, color: Colors.black54),
  //                     ),
  //                   ],
  //                 ),
  //               ),
  //               const Icon(
  //                 Icons.arrow_forward_ios,
  //                 size: 16,
  //                 color: Colors.black54,
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       const Expanded(
  //         child: Center(
  //           child: Text(
  //             'Home Screen Content',
  //             style: TextStyle(fontSize: 18, color: Colors.black54),
  //           ),
  //         ),
  //       ),
  //       ElevatedButton(
  //         onPressed: () async {
  //           var token = await dataBase.getToken();
  //           print(token);
  //         },
  //         child: Text('token print'),
  //       ),
  //     ],
  //   );
  // }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () async {
              var token = await dataBase.getToken();
              print(token);
            },
          ),
          //  IconButton(icon: Icon(Icons.person), onPressed: () {}),
        ],
      ),
      drawer: _buildDrawer(),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        return RefreshIndicator(
          onRefresh: controller.refreshDashboard,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Stats Cards Row 1
                // _buildStatCard(
                //   'Sales Today',
                //   '₦${controller.salesToday.value}',
                //   Icons.attach_money,
                //   Colors.green,
                // ),
                GestureDetector(
                  onTap: () async {},
                  child: _buildStatCard(
                    'Sales Today',
                    '₦${controller.salesToday.value}',
                    Icons.attach_money,
                    Colors.green,
                  ),
                ),
                SizedBox(height: 12),
                _buildStatCard(
                  'Orders Today',
                  '${controller.ordersToday.value}',
                  Icons.shopping_cart,
                  Colors.blue,
                ),
                SizedBox(height: 12),

                // Stats Cards Row 2
                _buildStatCard(
                  'Total Products',
                  '${controller.totalProducts.value}',
                  Icons.inventory,
                  Colors.orange,
                ),
                SizedBox(height: 12),
                _buildStatCard(
                  'Active Promotions',
                  '${controller.activePromotions.value}',
                  Icons.local_offer,
                  Colors.purple,
                ),
                SizedBox(height: 12),

                // Stats Cards Row 3
                _buildStatCard(
                  'Low Stock Alert',
                  '${controller.lowStockCount.value}',
                  Icons.warning,
                  Colors.red,
                ),
                SizedBox(height: 12),
                _buildStatCard(
                  'Pending Orders',
                  '${controller.pendingOrders.value}',
                  Icons.pending,
                  Colors.amber,
                ),
                SizedBox(height: 24),

                // Revenue Chart
                Text(
                  'Revenue (Month)',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 12),
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Center(child: Text('Chart: Revenue vs Month')),
                ),
                SizedBox(height: 24),

                // Top Selling Products
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 12),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          'Top Selling Products',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 12),
                      ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.topProducts.length,
                        itemBuilder: (context, index) {
                          var product = controller.topProducts[index];
                          return Card(
                            elevation: 0,
                            color: Colors.white,

                            surfaceTintColor: Colors.white,
                            //margin: EdgeInsets.only(bottom: 8),
                            child: ListTile(
                              leading: CircleAvatar(
                                radius: 15,
                                backgroundColor: Color(
                                  0xFF004DBF,
                                ).withValues(alpha: .2),
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: Color(0xFF004DBF),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              title: Text(
                                product['name'] ?? '',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text('${product['categoryName']}'),
                              trailing: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    '₦${product['revenue']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Text('${product['sold']} in Stock'),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                            ),
                            child: Divider(),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(width: 1, color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Icon(icon, color: color, size: 28),
              Text(
                title,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              ),
              // Container(
              //   padding: EdgeInsets.all(4),
              //   decoration: BoxDecoration(
              //     color: color.withOpacity(0.1),
              //     borderRadius: BorderRadius.circular(4),
              //   ),
              // child: //Icon(icon, color: color, size: 28),
              // ),
            ],
          ),
          //   SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                value,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
            ],
          ),
          SizedBox(height: 4),
        ],
      ),
    );
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
                  //  ambiguate(value)
                  '${firstName} ${lastName}',
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
          _buildDrawerItem(
            Icons.shopping_bag_outlined,
            'Orders',
            () => Get.toNamed(AppRoutes.orderList),
          ),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Settings', () async {
            // Navigate to settings
          }),
          _buildDrawerItem(Icons.logout, 'Logout', () async {
            await dataBase.logOut();
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(leading: Icon(icon), title: Text(title), onTap: onTap);
  }
}

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
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
    myLog.log('first name $fname ans last name $lastName');
  }

  @override
  Widget build(BuildContext context) {
    return const OrdersScreen();
  }
}

class WalletTab extends StatelessWidget {
  const WalletTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletScreen();
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProfileScreen();
  }
}
