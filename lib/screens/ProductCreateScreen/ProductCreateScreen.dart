import 'package:ctlvendor/screens/ProductCreateScreen/controller/ProductCreateController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// lib/screens/products/product_create_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import '../../controllers/product_controller.dart';
//ProductCreateController controller = Get.put(ProductCreateController());

class ProductCreateScreen extends StatelessWidget {
  ProductCreateScreen(this.controller, {Key? key}) : super(key: key);
  //final ProductController controller = Get.find<ProductController>();
  final ProductCreateController controller;
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController skuController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController costController = TextEditingController();
  final TextEditingController stockController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: Colors.black),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Add New Product',
          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Product Name
              _buildLabel('Product Name'),
              SizedBox(height: 8),
              TextFormField(
                controller: nameController,
                decoration: _inputDecoration('Enter product name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter product name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),

              // Category and Pack in Row
              // Row(
              //   children: [
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           _buildLabel('Category'),
              //           SizedBox(height: 8),
              //           DropdownSearch<String>(
              //             items: ['Beverages', 'Snacks', 'Dairy', 'Bakery'],
              //             popupProps: PopupProps.menu(
              //               showSearchBox: true,
              //               searchFieldProps: TextFieldProps(
              //                 decoration: InputDecoration(
              //                   hintText: 'Search category...',
              //                   border: OutlineInputBorder(
              //                     borderRadius: BorderRadius.circular(8),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //             dropdownDecoratorProps: DropDownDecoratorProps(
              //               decoration: _inputDecoration('Select category'),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //     SizedBox(width: 16),
              //     Expanded(
              //       child: Column(
              //         crossAxisAlignment: CrossAxisAlignment.start,
              //         children: [
              //           _buildLabel('Pack'),
              //           SizedBox(height: 8),
              //           DropdownSearch<String>(
              //             items: ['500ml Bottle', 'Pack of 12', '1 Liter', 'Single Unit'],
              //             popupProps: PopupProps.menu(
              //               showSearchBox: true,
              //             ),
              //             dropdownDecoratorProps: DropDownDecoratorProps(
              //               decoration: _inputDecoration('Select pack'),
              //             ),
              //           ),
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              SizedBox(height: 20),

              // SKU
              _buildLabel('SKU'),
              SizedBox(height: 8),
              TextFormField(
                controller: skuController,
                decoration: _inputDecoration('SKU-XXX-XXX'),
                style: TextStyle(color: Colors.grey[500]),
              ),
              SizedBox(height: 20),

              // Price, Cost, Stock in Row
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Price'),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration('0'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Cost (Optional)'),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: costController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration('0'),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLabel('Stock'),
                        SizedBox(height: 8),
                        TextFormField(
                          controller: stockController,
                          keyboardType: TextInputType.number,
                          decoration: _inputDecoration('0'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Required';
                            }
                            return null;
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Description
              _buildLabel('Description'),
              SizedBox(height: 8),
              TextFormField(
                controller: descriptionController,
                maxLines: 4,
                decoration: _inputDecoration('Enter product description'),
              ),
              SizedBox(height: 20),

              // Status
              _buildLabel('Status'),
              SizedBox(height: 8),
              DropdownButtonFormField<String>(
                decoration: _inputDecoration(''),
                value: 'Active',
                items: ['Active', 'Inactive']
                    .map((status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ))
                    .toList(),
                onChanged: (value) {},
              ),
              SizedBox(height: 40),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Get.back(),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        side: BorderSide(color: Colors.grey[300]!),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Save product
                          Get.back();
                          Get.snackbar('Success', 'Product added successfully');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        'Save',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
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

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.red),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }
}