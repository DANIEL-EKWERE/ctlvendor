import 'package:ctlvendor/screens/operation/controller/operation_controller.dart';
import 'package:ctlvendor/widgets/back_button.dart';
import 'package:ctlvendor/widgets/status_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:developer' as myLog;

OperationController controller = Get.put(OperationController());

class OperationsScreen extends StatefulWidget {
  const OperationsScreen({this.onTimeSelected, this.selectedTime, super.key});
  final Function(TimeOfDay)? onTimeSelected;
  final TimeOfDay? selectedTime;

  @override
  State<OperationsScreen> createState() => _OperationsScreenState();
}

class _OperationsScreenState extends State<OperationsScreen> {
  Future<void> _selectTime(BuildContext context) async {
    print('object');
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff004BFD),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // widget.onTimeSelected!(picked);
      setState(() {
        controller.earlestPreOrderTimeController.text = _formatTime(picked);
      });
    }
  }

  Future<void> _selectOrderCutOffTime(BuildContext context) async {
    print('object');
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff004BFD),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // widget.onTimeSelected!(picked);
      myLog.log(picked.hour.toString());
      setState(() {
        controller.orderCutOffTimeController.text = _formatTime(picked);
      });
    }
  }

  Future<void> _selectOrderFulfillmentTime(BuildContext context) async {
    print('object');
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: widget.selectedTime ?? TimeOfDay.now(),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Color(0xff004BFD),
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // widget.onTimeSelected!(picked);
      setState(() {
        controller.orderFulfilmentController.text = _formatTime(picked);
      });
    }
  }

  String _formatTime1(TimeOfDay time) {
    final hour = time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '${hour == 0 ? 12 : hour}:$minute $period';
  }

  String _formatTime(TimeOfDay time) {
    final hour = time.hour;
    final minute = time.minute.toString(); //.padLeft(2, '0');
    //final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute';
  }

  Widget _buildProgressIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
      child: Row(
        children: List.generate(
          5,
          (index) => Expanded(
            child: Container(
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: index < 3 ? Color(0XFF004BFD) : Colors.grey.shade300,
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
                    'Set up your operations',
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
              GestureDetector(
                onTap: () => _selectOrderFulfillmentTime(context),
                child: TextField(
                  onTap: () => _selectOrderFulfillmentTime(context),
                  readOnly: true,
                  //  maxLength: 11,
                  controller: controller.orderFulfilmentController,
                  decoration: const InputDecoration(
                    hintText: 'Order Fulfilment Type',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: () => _selectOrderCutOffTime(context),
                child: TextField(
                  onTap: () => _selectOrderCutOffTime(context),
                  readOnly: true,
                  //  maxLength: 11,
                  controller: controller.orderCutOffTimeController,
                  decoration: const InputDecoration(
                    hintText: 'Order Cut Off Time',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              GestureDetector(
                onTap: () => _selectTime(context),
                child: TextField(
                  onTap: () => _selectTime(context),
                  readOnly: true,
                  //  maxLength: 11,
                  controller: controller.earlestPreOrderTimeController,
                  decoration: const InputDecoration(
                    hintText: 'Earliest Pre-order Time',
                    hintStyle: TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              const Spacer(),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  controller.updateVendorOperation();
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
