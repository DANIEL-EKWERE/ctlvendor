import 'package:ctlvendor/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:ctlvendor/screens/summary_screen/controller/summary_controller.dart';
import 'package:ctlvendor/utils/storage.dart';
import '../../widgets/status_bar.dart';
import '../../widgets/back_button.dart';

SummaryController summaryController = Get.put(SummaryController());

class SummaryScreen extends StatefulWidget {
  const SummaryScreen({super.key});

  @override
  State<SummaryScreen> createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  @override
  void initState() {
    super.initState();
    setValue();
  }

  String firstName = '';
  String lastName = '';
  List<String> category = [];
  String phoneNumber = '';
  String email = '';
  String businessAddress = '';
  String paymentMethod = '';
  String categoryName = 'N/A';

  setValue() async {
    var firstName1 = await dataBase.getFirstName();
    var lastName1 = await dataBase.getLastName();
    var email1 = await dataBase.getEmail();
    var phoneNumber1 = await dataBase.getPhone();
    var address1 = await dataBase.getLocation();
    var category1 = await dataBase.loadSelectedProducts();
    var paymentMethod1 = await dataBase.getPaymentMethod() ?? 'Online';
    var cat = Get.arguments['category'];
    setState(() {
      firstName = firstName1;
      lastName = lastName1;
      category = category1;
      phoneNumber = phoneNumber1;
      businessAddress = address1;
      paymentMethod = paymentMethod1;
      email = email1;
      categoryName = cat;
    });
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: SizedBox(
        width: double.infinity,
        child: Row(
          children: List.generate(
            7,
            (index) => Expanded(
              child: Container(
                height: 4,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: index < 7 ? Color(0XFF004BFD) : Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatusBar(),
              _buildProgressIndicator(),
              const SizedBox(height: 16),
              Row(
                children: [
                  const CustomBackButton(),
                  const SizedBox(width: 16),
                  const Text(
                    'Summary',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSectionTitle('Business Details'),
                      const SizedBox(height: 16),
                      _buildBusinessDetails(),
                      const SizedBox(height: 24),
                      _buildSectionTitle('Payment Method'),
                      const SizedBox(height: 16),
                      _buildPaymentMethod(),
                      const SizedBox(height: 24),
                      // _buildSectionTitle('Subscription Plan'),
                      // const SizedBox(height: 16),
                      // _buildSubscriptionPlan(),
                      // const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
                child: const Text('Done'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w300),
    );
  }

  Widget _buildBusinessDetails() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Icon(Icons.person, color: Colors.grey.shade500),
              ),
            ),
            const SizedBox(width: 16),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "${firstName} ${lastName}",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Text(
                  //category.join('\n '),
                  categoryName,
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 24),
        Container(
          padding: EdgeInsets.all(12),
          width: double.infinity,
          decoration: BoxDecoration(
            color: Color(0xff2D2D2D).withValues(alpha: .04),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoRow(
                'Phone Number',
                phoneNumber.isNotEmpty ? phoneNumber : 'N/A',
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Email Address', email.isNotEmpty ? email : 'N/A'),
              const SizedBox(height: 16),
              _buildInfoRow(
                'Address',
                businessAddress.isNotEmpty ? businessAddress : 'N/A',
              ),
              const SizedBox(height: 16),
              _buildInfoRow('Website', email.isNotEmpty ? email : 'N/A'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod() {
    return Container(
      padding: EdgeInsets.all(12),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xff2D2D2D).withValues(alpha: .04),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            spacing: 10,
            children: [
              CustomImageView(
                height: 16,
                imagePath: 'assets/online_payment.png',
              ),

              Text(
                'Vendor Business Account',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 10),
          Text(
            "Payment details have been updated to receive payment online, you will receive your payment immediately you place request for widthdrawal \n\n Vendor business details also set, you can view them in your profile settings.",
            style: TextStyle(fontSize: 12, fontWeight: FontWeight.normal),
          ),
          // const SizedBox(height: 8),
          // Text(
          //   'Lorem ipsum dolor sit amet consectetur. Fames diam lobortis et tellus. Viverra in ut integer iaculis lectus.',
          //   style: TextStyle(
          //     fontSize: 14,
          //     color: Colors.grey.shade600,
          //     height: 1.5,
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildSubscriptionPlan() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Lorem Ipsum Dolor Sit',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Text(
          'Lorem ipsum dolor sit amet consectetur. Fames diam lobortis et tellus. Viverra in ut integer iaculis lectus.',
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
            height: 1.5,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
