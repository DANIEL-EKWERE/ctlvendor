import 'package:ctlvendor/screens/ProductCreateScreen/controller/ProductCreateController.dart';
import 'package:ctlvendor/widgets/custom_image_view.dart';
import 'package:flutter/material.dart';
import 'package:ctlvendor/screens/PackListScreen/models/model.dart' as pack;
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:ctlvendor/screens/ProductCreateScreen/models/productCategoryModel.dart'
    as cat;
import 'package:ctlvendor/screens/ProductCreateScreen/models/adminProductModel.dart'
    as productModel;
import 'dart:developer' as myLog;
import 'dart:io';

// lib/screens/products/product_create_screen.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
// import '../../controllers/product_controller.dart';
//ProductCreateController controller = Get.put(ProductCreateController());

class ProductCreateScreen extends StatefulWidget {
  ProductCreateScreen(this.controller, {Key? key}) : super(key: key);
  //final ProductController controller = Get.find<ProductController>();
  final ProductCreateController controller;

  @override
  State<ProductCreateScreen> createState() => _ProductCreateScreenState();
}

class _ProductCreateScreenState extends State<ProductCreateScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController skuController = TextEditingController();

  final TextEditingController priceController = TextEditingController();

  final TextEditingController costController = TextEditingController();

  final TextEditingController stockController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  @override
  initState() {
    super.initState();
    // You can initialize any data here if needed
    widget.controller.fetchProducts();
    widget.controller.fetchPacks();
    widget.controller.fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   leading: IconButton(
      //     icon: Icon(Icons.close, color: Colors.black),
      //     onPressed: () => Get.back(),
      //   ),
      //   title: Text(
      //     'Add New Product',
      //     style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w600),
      //   ),
      //   centerTitle: true,
      // ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(width: 10),
                    Text(
                      'Add Product',
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
                // Product Name
                _buildLabel('Product Name'),
                SizedBox(height: 8),
                // TextFormField(
                //   controller: nameController,
                //   decoration: _inputDecoration('Enter product name'),
                //   validator: (value) {
                //     if (value == null || value.isEmpty) {
                //       return 'Please enter product name';
                //     }
                //     return null;
                //   },
                // ),
                DropdownSearch<productModel.Data>(
                  onChanged: (value) async {
                    setState(() {
                      widget.controller.selectedProduct.value = value!.name!;
                      widget.controller.selectedProductId.value = value.id
                          .toString();
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
                      //  ? widget.controller.selectedProductId.value != ''
                      ? productModel.Data(
                          id: int.tryParse(
                            widget.controller.selectedProductId.value,
                          ),
                          name: widget.controller.selectedProduct.value,
                        )
                      // productModel.Data(
                      //     id: int.parse(widget.controller.selectedProductId ?? '0'),
                      //     product: productModel.Product(
                      //       name: widget.controller.selectedProduct,
                      //     ),
                      //   )
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
                      return Text(selectedItem.name!);
                    } else {
                      return Text(
                        'Enter Your Product Name',
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      );
                    }
                  },
                  items: (f, cs) => widget.controller.isLoading.value
                      ? []
                      : widget.controller.productList,
                  //
                  itemAsString: (item) {
                    return item.name ?? '';
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
                        'Search Product',
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

                SizedBox(height: 20),

                // SKU
                _buildLabel('Pack'),
                SizedBox(height: 8),

                // TextFormField(
                //   controller: skuController,
                //   decoration: _inputDecoration('SKU-XXX-XXX'),
                //   style: TextStyle(color: Colors.grey[500]),
                // ),
                DropdownSearch<pack.Data>(
                  onChanged: (value) async {
                    setState(() {
                      widget.controller.selectedPack.value = value!.name!;
                      widget.controller.selectedPackId.value = value.id
                          .toString();
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
                  selectedItem: widget.controller.selectedPack.value != null
                      //  ? widget.controller.selectedProductId.value != ''
                      ? pack.Data(
                          id: int.tryParse(
                            widget.controller.selectedPackId.value,
                          ),
                          name: widget.controller.selectedPack.value,
                        )
                      // productModel.Data(
                      //     id: int.parse(widget.controller.selectedProductId ?? '0'),
                      //     product: productModel.Product(
                      //       name: widget.controller.selectedProduct,
                      //     ),
                      //   )
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
                      return Text(selectedItem.name!);
                    } else {
                      return Text(
                        'Enter Your Pack Name',
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      );
                    }
                  },
                  items: (f, cs) => widget.controller.isLoading1.value
                      ? []
                      : widget.controller.packs,
                  //
                  itemAsString: (item) {
                    return item.name ?? '';
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
                        'Search Product',
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
                // Category
                _buildLabel('Category Name'),
                SizedBox(height: 8),

                DropdownSearch<cat.Data>(
                  onChanged: (value) async {
                    setState(() {
                      widget.controller.selectedCategory.value = value!.name!;
                      widget.controller.selectedCategoryId.value = value.id
                          .toString();
                    });
                    // print('selected item is: ${controller.selectedCountry1}');
                    // print(
                    //     'selected item Id is: ${controller.selectedCountryId}');

                    assert(
                      widget.controller.selectedCategory.value != null,
                      'Selected category should not be null',
                    );

                    //await controller.fetchStates();
                    // myLog.log(
                    //   'Selected product: ${controller.selectedProduct}',
                    // );
                  },
                  selectedItem: widget.controller.selectedCategory.value != null
                      //  ? widget.controller.selectedProductId.value != ''
                      ? cat.Data(
                          id: int.tryParse(
                            widget.controller.selectedCategoryId.value,
                          ),
                          name: widget.controller.selectedCategory.value,
                        )
                      // productModel.Data(
                      //     id: int.parse(widget.controller.selectedProductId ?? '0'),
                      //     product: productModel.Product(
                      //       name: widget.controller.selectedProduct,
                      //     ),
                      //   )
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
                      return Text(selectedItem.name!);
                    } else {
                      return Text(
                        'Enter Your Category Name',
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      );
                    }
                  },
                  items: (f, cs) => widget.controller.isLoading2.value
                      ? []
                      : widget.controller.categoryList,
                  //
                  itemAsString: (item) {
                    return item.name ?? '';
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
                                'No categories found',
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
                        'Search Category',
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
                SizedBox(height: 30),

                // Price, Cost, Stock in Row
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Price'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: widget.controller.priceController,
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
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Cost (Optional)'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller: widget.controller.costController,
                      keyboardType: TextInputType.number,
                      decoration: _inputDecoration('0'),
                    ),
                  ],
                ),
                SizedBox(height: 30),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildLabel('Stock'),
                    SizedBox(height: 8),
                    TextFormField(
                      controller:
                          widget.controller.stockController, //stockController,
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

                SizedBox(height: 30),

                // Description
                _buildLabel('Description'),
                SizedBox(height: 8),
                TextFormField(
                  controller: widget.controller.descriptionController,
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
                      .map(
                        (status) => DropdownMenuItem(
                          value: status,
                          child: Text(status),
                        ),
                      )
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      // Handle status change
                      print(value);
                      widget.controller.isActive.value = value == 'Active'
                          ? 1
                          : 0;
                    }
                  },
                ),
                SizedBox(height: 30),

                // Product Images Section
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
                                                        BorderRadius.circular(
                                                          6,
                                                        ),
                                                    color: Colors.black
                                                        .withOpacity(0.3),
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
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
                                                        BorderRadius.circular(
                                                          4,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    '${index + 1}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 11,
                                                      fontWeight:
                                                          FontWeight.bold,
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
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
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

                            //  Get.back();
                            // Get.snackbar(
                            //   'Success',
                            //   'Product added successfully',
                            // );
                            widget.controller.createProduct();
                          }
                          print('object');
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
