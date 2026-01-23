import 'package:ctlvendor/screens/LocationCreateScreen/controller/LocationCreateController.dart';
import 'package:ctlvendor/screens/LocationListScreen/models/model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/country_model.dart';
import 'package:ctlvendor/screens/checkout_address_change/models/lga_model.dart'
    as lgaData;
import 'package:ctlvendor/screens/checkout_address_change/models/state_model.dart';
import 'package:ctlvendor/screens/faq_screen/faq_screen.dart';
import 'package:ctlvendor/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'dart:developer' as myLog;

//LocationCreateController widget.controller = Get.put(LocationCreateController());

class LocationEditScreen extends StatefulWidget {
  const LocationEditScreen(this.controller, this.location, {super.key});
  final LocationCreateController controller;
  final Data location;
  @override
  State<LocationEditScreen> createState() => _LocationCreateScreenState();
}

class _LocationCreateScreenState extends State<LocationEditScreen> {
  String _locationMessage = "";

  void initState() {
    // TODO: implement initState
    super.initState();
    widget.controller.fetchCountries();
    widget.controller.edtContactAddressController.text =
        widget.location.contactAddress!;
    myLog.log('printing location address: ${widget.location.contactAddress}');
    //  widget.controller.contactAddressController.text;
    widget.controller.editContactNumberController.text =
        widget.location.phone ?? 'N/A';
    widget.controller.selectedCountry1 = widget.location.country ?? 'N/A';
    widget.controller.selectedState1 = widget.location.state ?? 'N/A';
    widget.controller.selectedLGA1 = widget.location.lga ?? 'N/A';
    //  widget.controller.contactNumberController.text;
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
        widget.controller.lat?.value = position.latitude.toString();
        widget.controller.long?.value = position.longitude.toString();
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
            //   widget.controller: widget.controller.locationNameController,
            //   decoration: InputDecoration(
            //     labelText: 'Location Name',
            //   ),
            // ),
            // TextField(
            //   widget.controller: widget.controller.descriptionController,
            //   decoration: InputDecoration(
            //     labelText: 'Description',
            //   ),
            // ),
            // ElevatedButton(
            //   onPressed: () {
            //     widget.controller.createLocation();
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
                          widget.controller.selectedCountry1 = value!.name;
                          widget.controller.selectedCountryId = value.id;
                        });
                        // print('selected item is: ${widget.controller.selectedCountry1}');
                        // print(
                        //     'selected item Id is: ${widget.controller.selectedCountryId}');

                        assert(
                          widget.controller.selectedCountry1 != null,
                          'Selected country should not be null',
                        );

                        await widget.controller.fetchStates();
                        myLog.log(
                          'Selected country: ${widget.controller.selectedCountry1}',
                        );
                      },
                      selectedItem: widget.controller.selectedCountry,
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
                      items: (f, cs) => widget.controller.isCountryLoading.value
                          ? []
                          : widget.controller.countryDataList,
                      //
                      itemAsString: (item) {
                        return item.name ?? '';
                      },
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        searchDelay: const Duration(seconds: 0),
                        emptyBuilder: (context, searchEntry) {
                          return widget.controller.isCountryLoading.value
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
                          widget.controller.selectedState1 = value!.name;
                          widget.controller.selectedStateId = value.id;
                        });
                        print(
                          'selected item is: ${widget.controller.selectedState1}',
                        );
                        await widget.controller.fetchLgas(
                          widget.controller.selectedState1!,
                        );
                        myLog.log(
                          'Selected state: ${widget.controller.selectedState1}',
                        );
                        myLog.log(
                          'Selected state ID: ${widget.controller.selectedStateId}',
                        );
                      },
                      selectedItem: widget.controller.selectedState,
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
                      items: (f, cs) => widget.controller.isStateLoading.value
                          ? []
                          : widget.controller.stateDataList,
                      itemAsString: (item) {
                        return item.name ?? '';
                      },
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        searchDelay: const Duration(seconds: 0),
                        emptyBuilder: (context, searchEntry) {
                          return widget.controller.isStateLoading.value
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
                          widget.controller.selectedLGA1 = value!.name;
                          widget.controller.selectedLGAId = value.id;
                        });
                        // print('selected item is: ${widget.controller.selectedLGA1}');
                        // myLog.log('Selected LGA: ${widget.controller.selectedLGA1}');
                        // myLog.log('Selected LGA ID: ${widget.controller.selectedLGAId}');
                      },
                      selectedItem: widget.controller.selectedLGA,
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
                      items: (f, cs) => widget.controller.isLgaLoading.value
                          ? []
                          : widget.controller.lgaDataList,
                      //
                      itemAsString: (item) {
                        return item.name ?? '';
                      },
                      popupProps: PopupProps.menu(
                        showSelectedItems: true,
                        searchDelay: const Duration(seconds: 0),
                        emptyBuilder: (context, searchEntry) {
                          return widget.controller.isStateLoading.value
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
              controller: widget.controller.edtContactAddressController,
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
              controller: widget.controller.editContactNumberController,
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
                      // widget.controller.editPacks(widget.product.id.toString());
                      widget.controller.updateAddress(
                        widget.location.id.toString(),
                      );
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
