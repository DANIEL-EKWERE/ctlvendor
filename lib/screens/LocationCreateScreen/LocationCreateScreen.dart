import 'package:ctlvendor/screens/LocationCreateScreen/controller/LocationCreateController.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/country_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/lga_model.dart'
    as lgaData;
import 'package:ctlvendor/screens/checkout_address_change/models/state_model.dart';
import 'package:ctlvendor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:developer' as myLog;

LocationCreateController controller = Get.put(LocationCreateController());

class LocationCreateScreen extends StatefulWidget {
  const LocationCreateScreen({super.key});
  //final LocationCreateController controller;

  @override
  State<LocationCreateScreen> createState() => _LocationCreateScreenState();
}

class _LocationCreateScreenState extends State<LocationCreateScreen> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Text(
                  'Create Location',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
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

            // TextField(
            //   controller: controller.locationNameController,
            //   decoration: InputDecoration(
            //     labelText: 'Location Name',
            //   ),
            // ),
            // TextField(
            //   controller: controller.descriptionController,
            //   decoration: InputDecoration(
            //     labelText: 'Description',
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     controller.createLocation();
            //   },
            //   child: Text('Create Location'),
            // ),
            Row(
              spacing: 10,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      //horizontal: 6.0,
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
                          contentPadding: EdgeInsets.zero,
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
                          return Text(
                            selectedItem.name!,
                            style: TextStyle(fontSize: 10),
                          );
                        } else {
                          return Text(
                            'Country',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 10,
                            ),
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
                                    color: Colors.amber,
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
                            const SnackBar(
                              content: Text("move to the next item"),
                            ),
                          );
                          myLog.log('Next items found.');
                        },
                        onItemsLoaded: (value) {
                          myLog.log(
                            'Items loaded: ${value.length} items found.',
                          );
                        },
                        scrollbarProps: const ScrollbarProps(),
                        showSearchBox: true,
                        searchFieldProps: const TextFieldProps(),
                        // disabledItemFn: (item) => item == 'Item 3',
                        fit: FlexFit.loose,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      //   horizontal: 6.0,
                    ),
                    child: DropdownSearch<StateData>(
                      onChanged: (value) async {
                        setState(() {
                          controller.selectedState1 = value!.name;
                          controller.selectedStateId = value.id;
                        });
                        print('selected item is: ${controller.selectedState1}');
                        await controller.fetchLgas(controller.selectedState1!);
                        myLog.log(
                          'Selected state: ${controller.selectedState1}',
                        );
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
                        baseStyle: TextStyle(color: Colors.white, fontSize: 10),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.zero,
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
                          return Text(
                            selectedItem.name!,
                            style: TextStyle(fontSize: 10),
                          );
                        } else {
                          return Text(
                            'State',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 10,
                            ),
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
                            const SnackBar(
                              content: Text("move to the next item"),
                            ),
                          );
                          myLog.log('Next items found.');
                        },
                        onItemsLoaded: (value) {
                          myLog.log(
                            'Items loaded: ${value.length} items found.',
                          );
                        },
                        scrollbarProps: const ScrollbarProps(),
                        showSearchBox: true,
                        searchFieldProps: const TextFieldProps(),
                        // disabledItemFn: (item) => item == 'Item 3',
                        fit: FlexFit.loose,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      //    horizontal: 6.0,
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
                          contentPadding: EdgeInsets.zero,
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
                          return Text(
                            selectedItem.name!,
                            style: TextStyle(fontSize: 10),
                          );
                        } else {
                          return Text(
                            'LGA',
                            style: TextStyle(
                              color: Colors.grey[300],
                              fontSize: 12,
                            ),
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
                            const SnackBar(
                              content: Text("move to the next item"),
                            ),
                          );
                          myLog.log('Next items found.');
                        },
                        onItemsLoaded: (value) {
                          myLog.log(
                            'Items loaded: ${value.length} items found.',
                          );
                        },
                        scrollbarProps: const ScrollbarProps(),
                        showSearchBox: true,
                        searchFieldProps: const TextFieldProps(),
                        // disabledItemFn: (item) => item == 'Item 3',
                        fit: FlexFit.loose,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text('Contact Address'),
            SizedBox(height: 5),
            TextField(
              controller: controller.contactAddressController,
              decoration: InputDecoration(
                hintText: 'Contact Address',
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
            Text('Phone Number'),
            SizedBox(height: 5),
            TextField(
              controller: controller.contactNumberController,
              decoration: InputDecoration(
                hintText: 'Phone Number',
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
            DropdownButtonFormField<String>(
              initialValue: controller.isActive.value ? 'Active' : 'Inactive',
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
                print(newValue);
                if (newValue == 'Active') {
                  controller.isActive.value = true;
                } else {
                  controller.isActive.value = false;
                }
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
            Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(
                  width: 90,
                  height: 40,
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
                  height: 40,
                  child: CustomButton(
                    text: 'Save',
                    onPressed: () {
                      Get.back();
                      controller.storeAddress();
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
