import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rentrover/controllers/booking_controller.dart';

class BookingPage extends StatelessWidget {
  final String carId;
  const BookingPage({super.key, required this.carId});

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.put(BookingController(carId));
    debugPrint('[BookingPage] Initialized with carId: $carId');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Your Ride'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Obx(() => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Select Date Range',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: () {
                debugPrint('[BookingPage] Date range picker tapped');
                bookingController.selectDateRange();
              },
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${bookingController.formatDate(bookingController.startDate.value)} - ${bookingController.formatDate(bookingController.endDate.value)}',
                    ),
                    const Icon(Icons.date_range),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text('Pick Time Slots',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('[BookingPage] Start time picker tapped');
                      bookingController.selectTime(true);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('From: ${bookingController.formatTime(bookingController.startTime.value)}'),
                          const Icon(Icons.access_time),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      debugPrint('[BookingPage] End time picker tapped');
                      bookingController.selectTime(false);
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('To: ${bookingController.formatTime(bookingController.endTime.value)}'),
                          const Icon(Icons.access_time_outlined),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  debugPrint('[BookingPage] Confirm Booking button pressed');
                  final available = await bookingController.checkAvailability();
                  debugPrint('[BookingPage] Availability: ${available ? 'Available' : 'Not Available'}');

                  if (available) {
                    debugPrint('[BookingPage] Proceeding to book...');
                    await bookingController.bookCar();
                  } else {
                    debugPrint('[BookingPage] Booking blocked due to unavailability');
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Obx(() => bookingController.isChecking.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Proceed to Pay',
                    style: TextStyle(color: Colors.white, fontSize: 16))),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
