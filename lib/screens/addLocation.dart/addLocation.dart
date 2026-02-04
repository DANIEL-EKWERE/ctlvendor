import 'package:ctlvendor/screens/addLocation.dart/controller/addLocationController.dart';
import 'package:ctlvendor/widgets/back_button.dart';
import 'package:ctlvendor/widgets/custom_textfield.dart' hide CustomTextField;
import 'package:ctlvendor/widgets/status_bar.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as myLog;

import 'package:get/get.dart';

import 'dart:developer' as myLog;
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:ctlvendor/screens/checkout_address_change/controller/checkout_address_change_controller.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/country_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/lga_model.dart'
    as lgaData;
import 'package:ctlvendor/screens/checkout_address_change/models/state_model.dart';
import 'package:ctlvendor/screens/profile_screen/controller/profile_controller.dart';
import 'package:ctlvendor/widgets/custom_button.dart';
import 'package:ctlvendor/widgets/custom_text_field.dart';

AddLocationcontroller controller = Get.put(AddLocationcontroller());

class Addlocation extends StatefulWidget {
  const Addlocation({super.key});

  @override
  State<Addlocation> createState() => _AddlocationState();
}

class _AddlocationState extends State<Addlocation> {
  String _locationMessage = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    controller.fetchCountries();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      setState(() {
        _locationMessage = 'Location services are disabled.';
      });
      return;
    }

    // Check location permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        setState(() {
          _locationMessage = 'Location permissions are denied';
        });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      setState(() {
        _locationMessage = 'Location permissions are permanently denied';
      });
      return;
    }

    // Get current position
    try {
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),

        //desiredAccuracy: LocationAccuracy.high,
      );

      setState(() {
        _locationMessage =
            'Lat: ${position.latitude}, Lng: ${position.longitude}';
        controller.lat?.value = position.latitude.toString();
        controller.long?.value = position.longitude.toString();
      });
    } catch (e) {
      setState(() {
        _locationMessage = 'Error: $e';
      });
    }
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        children: List.generate(
          7,
          (index) => Expanded(
            child: Container(
              height: 3,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index < 4 ? Color(0XFF004BFD) : Colors.grey.shade300,
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
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
                    'Set up your business location',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff004BFD),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              const SizedBox(height: 28),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16.0,
                ),
                child: DropdownSearch<CountryData>(
                  onChanged: (value) async {
                    setState(() {
                      controller.selectedCountry1 = value!.name;
                      controller.selectedCountryId = value.id;
                    });
                    // print('selected item is: ${controller.selectedCountry1}');
                    // print(
                    //     'selected item Id is: ${controller.selectedCountryId}');

                    assert(
                      controller.selectedCountry1 != null,
                      'Selected country should not be null',
                    );

                    await controller.fetchStates();
                    myLog.log(
                      'Selected country: ${controller.selectedCountry1}',
                    );
                  },
                  selectedItem: controller.selectedCountry,
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
                        'Enter Your Country',
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      );
                    }
                  },
                  items: (f, cs) => controller.isCountryLoading.value
                      ? []
                      : controller.countryDataList,
                  //
                  itemAsString: (item) {
                    return item.name ?? '';
                  },
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    searchDelay: const Duration(seconds: 0),
                    emptyBuilder: (context, searchEntry) {
                      return controller.isCountryLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff004BFD),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No countries found',
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
              ),

              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16.0,
                ),
                child: DropdownSearch<StateData>(
                  onChanged: (value) async {
                    setState(() {
                      controller.selectedState1 = value!.name;
                      controller.selectedStateId = value.id;
                    });
                    print('selected item is: ${controller.selectedState1}');
                    await controller.fetchLgas(controller.selectedState1!);
                    myLog.log('Selected state: ${controller.selectedState1}');
                    myLog.log(
                      'Selected state ID: ${controller.selectedStateId}',
                    );
                  },
                  selectedItem: controller.selectedState,
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
                        'Enter Your State',
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      );
                    }
                  },
                  items: (f, cs) => controller.isStateLoading.value
                      ? []
                      : controller.stateDataList,
                  itemAsString: (item) {
                    return item.name ?? '';
                  },
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    searchDelay: const Duration(seconds: 0),
                    emptyBuilder: (context, searchEntry) {
                      return controller.isStateLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff004BFD),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No states found',
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
                        'Search State',
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
              ),

              //const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 10,
                  horizontal: 16.0,
                ),
                child: DropdownSearch<lgaData.LgaData>(
                  onChanged: (value) {
                    setState(() {
                      controller.selectedLGA1 = value!.name;
                      controller.selectedLGAId = value.id;
                    });
                    // print('selected item is: ${controller.selectedLGA1}');
                    // myLog.log('Selected LGA: ${controller.selectedLGA1}');
                    // myLog.log('Selected LGA ID: ${controller.selectedLGAId}');
                  },
                  selectedItem: controller.selectedLGA,
                  suffixProps: const DropdownSuffixProps(),
                  compareFn: (item1, item2) {
                    return item1 == item2;
                  },

                  decoratorProps: DropDownDecoratorProps(
                    baseStyle: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: const Color(0xffF5F5F5),
                      alignLabelWithHint: true,
                      suffixIconColor: Color(0xff004BFD),
                      focusedBorder: const OutlineInputBorder(
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
                          color: Colors.grey[300]!,
                          width: 1,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(12),
                        ),
                      ),
                      border: const OutlineInputBorder(
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
                        'Enter Your Local Government Area',
                        style: TextStyle(color: Colors.grey[300], fontSize: 16),
                      );
                    }
                  },
                  items: (f, cs) => controller.isLgaLoading.value
                      ? []
                      : controller.lgaDataList,
                  //
                  itemAsString: (item) {
                    return item.name ?? '';
                  },
                  popupProps: PopupProps.menu(
                    showSelectedItems: true,
                    searchDelay: const Duration(seconds: 0),
                    emptyBuilder: (context, searchEntry) {
                      return controller.isStateLoading.value
                          ? const Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff004BFD),
                              ),
                            )
                          : const Center(
                              child: Text(
                                'No states found',
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
                        'Search Local Government Area',
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
              ),

              // const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: CustomTextField(
                  hint: 'Contact Address',
                  controller: controller.contactAddressController,
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: CustomTextField(
                  hint: 'Phone Number',
                  controller: controller.contactNumberController,
                ),
              ),

              const Spacer(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.updateVendorBusinessLocation();
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
