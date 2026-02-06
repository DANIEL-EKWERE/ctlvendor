import 'package:ctlvendor/screens/PromotionCreateScreen/controller/PromotionCreateController.dart';
import 'package:ctlvendor/widgets/custom_button.dart';
import 'package:ctlvendor/widgets/custom_image_view.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;
import 'package:ctlvendor/screens/ProductListScreen/model/model.dart'
    as productModel;

//PromotionCreateController controller = Get.put(PromotionCreateController());

class PromotionCreateScreen extends StatefulWidget {
  const PromotionCreateScreen(this.controller, {super.key});

  final PromotionCreateController controller;

  @override
  State<PromotionCreateScreen> createState() => _PromotionCreateScreenState();
}

class _PromotionCreateScreenState extends State<PromotionCreateScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(8),

          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(width: 10),
                  Text(
                    'Add Promotion',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.cancel_outlined),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Text('Title'),
              SizedBox(height: 5),
              TextField(
                controller: widget.controller.promotionTitleController,
                decoration: InputDecoration(
                  hintText: 'Enter Promotion Title',
                  hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                  // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Discount Type'),
                        SizedBox(height: 5),
                        DropdownButtonFormField<String>(
                          initialValue:
                              widget.controller.discountType.value.isEmpty
                              ? null
                              : widget.controller.discountType.value,
                          items: <String>['percentage', 'Fixed Amount']
                              .map<DropdownMenuItem<String>>((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: TextStyle(fontSize: 11),
                                  ),
                                );
                              })
                              .toList(),
                          onChanged: (String? newValue) {
                            // Handle the selected value
                          },
                          decoration: InputDecoration(
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
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Discount Value'),
                        SizedBox(height: 5),
                        TextField(
                          // readOnly: true,
                          // onTap: () async {
                          //   DateTime? pickedDate = await showDatePicker(
                          //     context: context,
                          //     initialDate: DateTime.now(),
                          //     firstDate: DateTime(2000),
                          //     lastDate: DateTime(2101),
                          //   );

                          //   if (pickedDate != null) {
                          //     String formattedDate =
                          //         "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                          //     // You can use the formatted date as needed
                          //     print(formattedDate);
                          //   }
                          // },
                          controller: widget.controller.discountValueController,
                          decoration: InputDecoration(
                            hintText: 'Enter Discount Value',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start Date'),
                        SizedBox(height: 5),
                        TextField(
                          readOnly: true,
                          controller: widget.controller.startDateController,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                              // You can use the formatted date as needed
                              print(formattedDate);
                              widget.controller.startDateController.text =
                                  formattedDate;
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'Select Start Date',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
                      ],
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('End Date'),
                        SizedBox(height: 5),
                        TextField(
                          readOnly: true,
                          onTap: () async {
                            DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101),
                            );

                            if (pickedDate != null) {
                              String formattedDate =
                                  "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";

                              // You can use the formatted date as needed
                              print(formattedDate);
                              widget.controller.endDateController.text =
                                  formattedDate;
                            }
                          },
                          controller: widget.controller.endDateController,
                          decoration: InputDecoration(
                            hintText: 'Select End Date',
                            hintStyle: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14,
                            ),
                            // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
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
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              Text('Status'),
              SizedBox(height: 5),

              // TextField(
              //   //   controller: controller.priceModifierController,
              //   decoration: InputDecoration(
              //     hintText: 'Enter Price',
              //     hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
              //     // prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
              //     filled: true,
              //     fillColor: Colors.grey[50],
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide(color: Colors.grey[200]!),
              //     ),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide(color: Colors.grey[200]!),
              //     ),
              //     focusedBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(8),
              //       borderSide: BorderSide(color: Colors.black),
              //     ),
              //   ),
              // ),
              DropdownButtonFormField<String>(
                initialValue: widget.controller.isActive.value
                    ? 'Active'
                    : 'Inactive',
                items: <String>['Active', 'Inactive']
                    .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    })
                    .toList(),
                onChanged: (String? newValue) {
                  // Handle the selected value
                },
                decoration: InputDecoration(
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
              SizedBox(height: 30),
              DropdownSearch<productModel.Data>(
                onChanged: (value) async {
                  setState(() {
                    widget.controller.selectedProduct = value!.product!.name!;
                    widget.controller.productId = value.id.toString();
                  });
                  // print('selected item is: ${controller.selectedCountry1}');
                  // print(
                  //     'selected item Id is: ${controller.selectedCountryId}');

                  assert(
                    widget.controller.selectedProduct != null,
                    'Selected product should not be null',
                  );

                  //await controller.fetchStates();
                  // myLog.log(
                  //   'Selected product: ${controller.selectedProduct}',
                  // );
                },
                selectedItem: widget.controller.selectedProduct != null
                    ? productModel.Data(
                        id: int.parse(widget.controller.productId ?? '0'),
                        product: productModel.Product(
                          name: widget.controller.selectedProduct,
                        ),
                      )
                    : null,
                suffixProps: const DropdownSuffixProps(),
                compareFn: (item1, item2) {
                  return item1 == item2;
                },

                decoratorProps: const DropDownDecoratorProps(
                  baseStyle: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Color(0xffF5F5F5),
                    alignLabelWithHint: true,
                    suffixIconColor: Color(0xff004BFD),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Color(0xff004BFD),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(8)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Color(0xffD9D9D9),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        style: BorderStyle.solid,
                        color: Color(0xffD9D9D9),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(12)),
                    ),
                  ),
                ),
                dropdownBuilder: (context, selectedItem) {
                  if (selectedItem != null) {
                    return Text(selectedItem.product!.name!);
                  } else {
                    return Text(
                      'Enter Your Product Name',
                      style: TextStyle(color: Colors.grey[300], fontSize: 16),
                    );
                  }
                },
                items: (f, cs) => widget.controller.isLoading.value
                    ? []
                    : widget.controller.products,
                //
                itemAsString: (item) {
                  return item.product?.name ?? '';
                },
                popupProps: PopupProps.menu(
                  showSelectedItems: true,
                  searchDelay: const Duration(seconds: 0),
                  emptyBuilder: (context, searchEntry) {
                    return widget.controller.isLoading.value
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: Color(0xff004BFD),
                            ),
                          )
                        : const Center(
                            child: Text(
                              'No products found',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Poppins',
                                fontSize: 12,
                              ),
                            ),
                          );
                  },
                  title: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Search Country',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  onDismissed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("move to the next item")),
                    );
                    myLog.log('Next items found.');
                  },
                  onItemsLoaded: (value) {
                    myLog.log('Items loaded: ${value.length} items found.');
                  },
                  scrollbarProps: const ScrollbarProps(),
                  showSearchBox: true,
                  searchFieldProps: const TextFieldProps(),
                  // disabledItemFn: (item) => item == 'Item 3',
                  fit: FlexFit.loose,
                ),
              ),
              SizedBox(height: 20),
              _buildLabel('Product Images'),
              SizedBox(height: 12),
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(8),
                  color: Colors.grey[50],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Upload button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton.icon(
                        onPressed: () => widget.controller.pickImage(),
                        icon: Icon(Icons.add_photo_alternate_outlined),
                        label: Text('Add Images'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue[600],
                          padding: EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),

                    // Images List - Horizontal scroll
                    Obx(
                      () => widget.controller.selectedImages.isEmpty
                          ? Container(
                              height: 120,
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                  style: BorderStyle.solid,
                                ),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.image_not_supported_outlined,
                                      size: 40,
                                      color: Colors.grey[400],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      'No images selected',
                                      style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          : SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: List.generate(
                                  widget.controller.selectedImages.length,
                                  (index) => Padding(
                                    padding: EdgeInsets.only(right: 12),
                                    child: GestureDetector(
                                      onTap: () =>
                                          _showImageOptions(context, index),
                                      child: Container(
                                        width: 120,
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                          border: Border.all(
                                            color: Colors.grey[300]!,
                                            width: 2,
                                          ),
                                        ),
                                        child: Stack(
                                          children: [
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(6),
                                              child: CustomImageView(
                                                imagePath: widget
                                                    .controller
                                                    .selectedImages[index]
                                                    .path,
                                                fit: BoxFit.cover,
                                                width: 120,
                                                height: 120,
                                              ),
                                              //  Image.file(
                                              //   File(
                                              //     widget
                                              //         .controller
                                              //         .selectedImages[index]
                                              //         .path,
                                              //   ),
                                              //   fit: BoxFit.cover,
                                              //   width: 120,
                                              //   height: 120,
                                              // ),
                                            ),
                                            // Overlay on tap
                                            Positioned.fill(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(6),
                                                  color: Colors.black
                                                      .withOpacity(0.3),
                                                ),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.touch_app,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                    SizedBox(height: 4),
                                                    Text(
                                                      'Tap for options',
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize: 10,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            // Image counter badge
                                            Positioned(
                                              top: 4,
                                              right: 4,
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: 6,
                                                  vertical: 2,
                                                ),
                                                decoration: BoxDecoration(
                                                  color: Colors.blue[600],
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  '${index + 1}',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 11,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                    ),
                    SizedBox(height: 8),
                    Obx(
                      () => Text(
                        '${widget.controller.selectedImages.length} image(s) selected',
                        style: TextStyle(color: Colors.grey[600], fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 30),
              Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: CustomButton(
                      isOutlined: true,
                      text: 'Cancel',
                      onPressed: () {
                        Get.back();
                      },
                    ),
                  ),
                  SizedBox(
                    width: 90,
                    height: 50,
                    child: CustomButton(
                      text: 'Save',
                      onPressed: () {
                        Get.back();
                        widget.controller.createPromotion();
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
    );
  }

  void _showImageOptions(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Image #${index + 1}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: Colors.grey[100],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: CustomImageView(
                  imagePath: widget.controller.selectedImages[index].path,
                  fit: BoxFit.cover,
                ),
                //  Image.file(
                //   File(widget.controller.selectedImages[index].path),
                //   fit: BoxFit.cover,
                // ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      Get.back();
                      widget.controller.pickImageReplace(index);
                    },
                    icon: Icon(Icons.edit, color: Colors.blue),
                    label: Text(
                      'Replace',
                      style: TextStyle(color: Colors.blue),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      side: BorderSide(color: Colors.blue),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                      widget.controller.removeImage(index);
                      Get.snackbar(
                        'Deleted',
                        'Image removed',
                        snackPosition: SnackPosition.BOTTOM,
                        duration: Duration(seconds: 2),
                      );
                    },
                    icon: Icon(Icons.delete, color: Colors.white),
                    label: Text('Delete'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                      padding: EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () => Get.back(),
                child: Text('Close', style: TextStyle(color: Colors.grey[600])),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
