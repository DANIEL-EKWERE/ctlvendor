import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/screens/business_screen/controller/business_controller.dart';
import '../../widgets/status_bar.dart';
import '../../widgets/back_button.dart';
import 'dart:io';

BusinessController controller = Get.put(BusinessController());

Future<void> _showImageSourceDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Image Source'),
        content: const Text('Choose where to upload image from'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.obtainImageFromGallery();
            },
            child: const Text('Gallery'),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     controller.obtainImageFromCamera();
          //   },
          //   child: const Text('Camera'),
          // ),
        ],
      );
    },
  );
}

Future<void> _showDocumentSourceDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Document Source'),
        content: const Text('Choose where to upload document from'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.obtainDocumentFromGallery();
            },
            child: const Text('Gallery'),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     controller.obtainDocumentFromCamera();
          //   },
          //   child: const Text('Camera'),
          // ),
        ],
      );
    },
  );
}

Future<void> _showIdentificationSourceDialog(BuildContext context) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Select Identification Source'),
        content: const Text('Choose where to upload identification from'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              controller.obtainIdentificationFromGallery();
            },
            child: const Text('Gallery'),
          ),
          // TextButton(
          //   onPressed: () {
          //     Navigator.of(context).pop();
          //     controller.obtainIdentificationFromCamera();
          //   },
          //   child: const Text('Camera'),
          // ),
        ],
      );
    },
  );
}

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
      child: SizedBox(
        width: double.infinity,
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
                    DropdownMenuEntry(value: 'instant', label: 'INSTANT'),
                    DropdownMenuEntry(value: 'preorder', label: 'PRE-ORDER'),
                    DropdownMenuEntry(value: 'both', label: 'BOTH'),
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
                    DropdownMenuEntry(value: 'YES', label: 'YES'),
                    DropdownMenuEntry(value: 'NO', label: 'NO'),
                    // DropdownMenuEntry(
                    //   value: 'Rather not say',
                    //   label: 'Rather not say',
                    // ),
                  ],
                  // decoration: const InputDecoration(
                  //   labelText: 'Select an option',
                  //   border: OutlineInputBorder(),
                  // ),
                  onSelected: (String? value) {
                    print('Selected: $value');
                    setState(() {
                      controller.isBusinessRegistered.value = value == 'YES'
                          ? true
                          : false;
                      print(controller.isBusinessRegistered.value);
                    });
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
              // const SizedBox(height: 20),
              // TextField(
              //   controller: controller.rcNumberController,
              //   decoration: const InputDecoration(
              //     hintText: 'RC Number',
              //     hintStyle: TextStyle(color: Colors.grey),
              //     border: OutlineInputBorder(),
              //   ),
              // ),
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
              // Animated Identification Upload Section
              Obx(
                () => AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                  child: controller.meansOfIdentification.value.isNotEmpty
                      ? Column(
                          children: [
                            const SizedBox(height: 20),
                            GestureDetector(
                              onTap: () =>
                                  _showIdentificationSourceDialog(context),
                              child: Container(
                                height: 150,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color:
                                        controller.identificationFile.value ==
                                            null
                                        ? Colors.grey
                                        : Color(0XFF004BFD),
                                    width: 2,
                                  ),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child:
                                    controller.identificationFile.value == null
                                    ? Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Icon(
                                            Icons.file_copy_outlined,
                                            size: 48,
                                            color: Color(0XFF004BFD),
                                          ),
                                          const SizedBox(height: 8),
                                          Text(
                                            'Upload ${controller.meansOfIdentification.value.replaceAll('_', ' ').toUpperCase()}',
                                            style: const TextStyle(
                                              color: Color(0XFF004BFD),
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      )
                                    : Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          Image.file(
                                            File(
                                              controller
                                                  .identificationFile
                                                  .value!
                                                  .path,
                                            ),
                                            fit: BoxFit.cover,
                                          ),
                                          Positioned(
                                            right: 8,
                                            top: 8,
                                            child: GestureDetector(
                                              onTap: () =>
                                                  controller
                                                          .identificationFile
                                                          .value =
                                                      null,
                                              child: Container(
                                                decoration: const BoxDecoration(
                                                  color: Colors.red,
                                                  shape: BoxShape.circle,
                                                ),
                                                padding: const EdgeInsets.all(
                                                  4,
                                                ),
                                                child: const Icon(
                                                  Icons.close,
                                                  color: Colors.white,
                                                  size: 20,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 20),
              // Image Upload Section
              Obx(
                () => GestureDetector(
                  onTap: () => _showImageSourceDialog(context),
                  child: Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: controller.businessLogoFile.value == null
                            ? Colors.grey
                            : Color(0XFF004BFD),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: controller.businessLogoFile.value == null
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(
                                Icons.cloud_upload_outlined,
                                size: 48,
                                color: Color(0XFF004BFD),
                              ),
                              const SizedBox(height: 8),
                              const Text(
                                'Upload Business Logo',
                                style: TextStyle(
                                  color: Color(0XFF004BFD),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          )
                        : Stack(
                            alignment: Alignment.center,
                            children: [
                              Image.file(
                                File(controller.businessLogoFile.value!.path),
                                fit: BoxFit.cover,
                              ),
                              Positioned(
                                right: 8,
                                top: 8,
                                child: GestureDetector(
                                  onTap: () =>
                                      controller.businessLogoFile.value = null,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    padding: const EdgeInsets.all(4),
                                    child: const Icon(
                                      Icons.close,
                                      color: Colors.white,
                                      size: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              // Business Document Upload Section
              Obx(
                () => AnimatedSize(
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeInOut,

                  child: controller.isBusinessRegistered.value
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Business Documents',
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Obx(
                              () => GestureDetector(
                                onTap: () => _showDocumentSourceDialog(context),
                                child: Container(
                                  height: 150,
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color:
                                          controller
                                                  .businessDocumentFile
                                                  .value ==
                                              null
                                          ? Colors.grey
                                          : Color(0XFF004BFD),
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child:
                                      controller.businessDocumentFile.value ==
                                          null
                                      ? Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.cloud_upload_outlined,
                                              size: 48,
                                              color: Color(0XFF004BFD),
                                            ),
                                            const SizedBox(height: 8),
                                            const Text(
                                              'Upload Business Document',
                                              style: TextStyle(
                                                color: Color(0XFF004BFD),
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                          ],
                                        )
                                      : Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            Image.file(
                                              File(
                                                controller
                                                    .businessDocumentFile
                                                    .value!
                                                    .path,
                                              ),
                                              fit: BoxFit.cover,
                                            ),
                                            Positioned(
                                              right: 8,
                                              top: 8,
                                              child: GestureDetector(
                                                onTap: () =>
                                                    controller
                                                            .businessDocumentFile
                                                            .value =
                                                        null,
                                                child: Container(
                                                  decoration:
                                                      const BoxDecoration(
                                                        color: Colors.red,
                                                        shape: BoxShape.circle,
                                                      ),
                                                  padding: const EdgeInsets.all(
                                                    4,
                                                  ),
                                                  child: const Icon(
                                                    Icons.close,
                                                    color: Colors.white,
                                                    size: 20,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : SizedBox.shrink(),
                ),
              ),
              const SizedBox(height: 40),
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
