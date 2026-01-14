import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/screens/business_screen/controller/business_controller.dart';
import '../../widgets/status_bar.dart';
import '../../widgets/back_button.dart';

BusinessController controller = Get.put(BusinessController());

class BusinessNameScreen extends StatefulWidget {
  const BusinessNameScreen({super.key});

  @override
  State<BusinessNameScreen> createState() => _BusinessNameScreenState();
}

class _BusinessNameScreenState extends State<BusinessNameScreen> {
  // final TextEditingController _businessNameController = TextEditingController();

  @override
  void dispose() {
    // _businessNameController.dispose();
    super.dispose();
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        children: List.generate(
          6,
          (index) => Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index < 1 ? Color(0XFF004BFD) : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(2),
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
          child: ListView(
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const StatusBar(),
              _buildProgressIndicator(),
              const SizedBox(height: 16),
              const Row(
                children: [
                  CustomBackButton(),
                  SizedBox(width: 16),
                  Text(
                    'Complete your business\n profile',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff004BFD),
                    ),
                  ),
                ],
              ),

              // const SizedBox(height: 16),
              // Text(
              //   'Complete your business profile',
              //   style: TextStyle(
              //     fontSize: 14,
              //     color: Color(0xff004BFD),
              //     height: 1.5,
              //   ),
              // ),
              //const SizedBox(height: 28),
              const SizedBox(height: 20),
              TextField(
                controller: controller.businessNameController,
                decoration: const InputDecoration(
                  hintText: 'Business Name',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownMenuFormField<String>(
                  hintText: 'Business Type',
                  textStyle: TextStyle(color: Colors.grey),
                  width: double.infinity,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(
                      value: 'limited_liability',
                      label: 'Limited Liability',
                    ),
                    DropdownMenuEntry(
                      value: 'sole_proprietorship',
                      label: 'Sole Proprietorship',
                    ),
                    // DropdownMenuEntry(value: 'option3', label: 'Option 3'),
                  ],
                  // decoration: const InputDecoration(
                  //   labelText: 'Select an option',
                  //   border: OutlineInputBorder(),
                  // ),
                  onSelected: (String? value) {
                    print('Selected: $value');
                    controller.businessType.value = value!;
                  },
                ),
              ),
              // TextField(
              //   controller: controller.businessNameController,
              //   decoration: const InputDecoration(
              //     hintText: 'Business Type',
              //     hintStyle: TextStyle(color: Colors.grey),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
              const SizedBox(height: 20),
              TextField(
                maxLength: 11,
                controller: controller.bvnController,
                decoration: const InputDecoration(
                  hintText: 'BVN',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownMenuFormField<String>(
                  hintText: 'Fulfilment Type',
                  textStyle: TextStyle(color: Colors.grey),
                  width: double.infinity,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'instant', label: 'instant'),
                    DropdownMenuEntry(value: 'preorder', label: 'preorder'),
                    DropdownMenuEntry(value: 'both', label: 'both'),
                  ],
                  // decoration: const InputDecoration(
                  //   labelText: 'Select an option',
                  //   border: OutlineInputBorder(),
                  // ),
                  onSelected: (String? value) {
                    print('Selected: $value');
                    controller.fullfillmentType.value = value!;
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.cacNoController,
                decoration: const InputDecoration(
                  hintText: 'CAC No.',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.taxNoController,
                decoration: const InputDecoration(
                  hintText: 'Tax No.',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownMenuFormField<String>(
                  hintText: 'Is Business Registered',
                  textStyle: TextStyle(color: Colors.grey),
                  width: double.infinity,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: 'yes', label: 'yes'),
                    DropdownMenuEntry(value: 'no', label: 'no'),
                    DropdownMenuEntry(
                      value: 'Rather not say',
                      label: 'Rather not say',
                    ),
                  ],
                  // decoration: const InputDecoration(
                  //   labelText: 'Select an option',
                  //   border: OutlineInputBorder(),
                  // ),
                  onSelected: (String? value) {
                    print('Selected: $value');
                    controller.isBusinessRegistered.value = true;
                  },
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.contactAddressController,
                decoration: const InputDecoration(
                  hintText: 'Contact Address',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.businessDescriptionController,
                decoration: const InputDecoration(
                  hintText: 'Business Description',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: controller.rcNumberController,
                decoration: const InputDecoration(
                  hintText: 'RC Number',
                  hintStyle: TextStyle(color: Colors.grey),
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: DropdownMenuFormField<String>(
                  hintText: 'Means Of Identification',
                  textStyle: TextStyle(color: Colors.grey),
                  width: double.infinity,
                  dropdownMenuEntries: const [
                    //,,,
                    DropdownMenuEntry(value: 'voter_card', label: 'Voter Card'),
                    DropdownMenuEntry(value: 'nin', label: 'NIN'),
                    DropdownMenuEntry(
                      value: 'international_passport',
                      label: 'International Passport',
                    ),
                    DropdownMenuEntry(
                      value: 'driver_license',
                      label: 'Driver License',
                    ),
                  ],
                  // decoration: const InputDecoration(
                  //   labelText: 'Select an option',
                  //   border: OutlineInputBorder(),
                  // ),
                  onSelected: (String? value) {
                    print('Selected: $value');
                    controller.meansOfIdentification.value = value!;
                  },
                ),
              ),
              const Spacer(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.updateVendorProfileBusinessName();
                },
                child: const Text('Continue'),
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
