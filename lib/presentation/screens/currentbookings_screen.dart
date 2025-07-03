import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentrover/controllers/currentbooking_controller.dart';

class CurrentBookingsScreen extends StatefulWidget {
  @override
  State<CurrentBookingsScreen> createState() => _CurrentBookingsScreenState();
}

class _CurrentBookingsScreenState extends State<CurrentBookingsScreen> {
  final CurrentBookingsController controller = Get.find<CurrentBookingsController>();
  @override
  void initState() {
    super.initState();
    controller.fetchBookings();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text('Bookings',style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
      )),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }
        if (controller.bookings.isEmpty) {
          return Center(child: Text('No current bookings'));
        }

        return ListView.builder(
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            final car = booking['cars'];

            return Card(
              margin: EdgeInsets.all(12),
              child: ListTile(
                leading: car['images'] != null && car['images'].isNotEmpty
                    ? Image.network(car['images'][0], width: 60, fit: BoxFit.cover)
                    : Icon(Icons.directions_car, size: 40),
                title: Text(car['name'] ?? 'Car'),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('From: ${booking['start_time']}'),
                    Text('To: ${booking['end_time']}'),
                    Text('Status: ${booking['status']}'),
                    Text('Price per day: \$${car['price_per_day']}'),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
