import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentrover/controllers/currentbooking_controller.dart';
import 'package:intl/intl.dart';

class CurrentBookingsScreen extends StatefulWidget {
  const CurrentBookingsScreen({super.key});

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

  String formatDateTime(String dateTime) {
    try {
      final dt = DateTime.parse(dateTime);
      return DateFormat('dd MMM yyyy, hh:mm a').format(dt);
    } catch (e) {
      return dateTime;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text(
          'Current Bookings',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 26,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.bookings.isEmpty) {
          return const Center(
            child: Text(
              'No current bookings',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: controller.bookings.length,
          itemBuilder: (context, index) {
            final booking = controller.bookings[index];
            final car = booking['cars'];

            return Container(
              margin: const EdgeInsets.only(bottom: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // car image banner
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    child: car['images'] != null && car['images'].isNotEmpty
                        ? Image.network(
                      car['images'][0],
                      width: double.infinity,
                      height: 130,
                      fit: BoxFit.cover,
                    )
                        : Container(
                      width: double.infinity,
                      height: 180,
                      color: Colors.grey[300],
                      child: const Icon(
                        Icons.directions_car,
                        size: 70,
                        color: Colors.white,
                      ),
                    ),
                  ),

                  //booking info
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          car['name'] ?? 'Car',
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'From: ${formatDateTime(booking['start_time'])}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              'To: ${formatDateTime(booking['end_time'])}',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        // status badge
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: booking['status'] == 'confirmed'
                                ? Colors.green[100]
                                : Colors.orange[100],
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Status: ${booking['status']}',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: booking['status'] == 'confirmed'
                                  ? Colors.green[800]
                                  : Colors.orange[800],
                            ),
                          ),
                        ),

                        const SizedBox(height: 8),
                        Text(
                          'Price per day: ₹${car['price_per_day']}',
                          style: const TextStyle(
                            color: Colors.black87,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );

          },
        );
      }),
    );
  }
}
