import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:rentrover/controllers/booking_controller.dart';
import 'package:rentrover/data/models/car_model.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key, required this.car});
  final CarModel car;

  bool isSameTime(TimeOfDay t1, TimeOfDay t2) =>
      t1.hour == t2.hour && t1.minute == t2.minute;

  @override
  Widget build(BuildContext context) {
    final BookingController bookingController = Get.put(BookingController(car));

    // Update unavailable slots once when the page loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      bookingController.updateUnavailableSlots();
    });

    final List<TimeOfDay> popularSlots = [
      const TimeOfDay(hour: 9, minute: 0),
      const TimeOfDay(hour: 12, minute: 0),
      const TimeOfDay(hour: 15, minute: 0),
      const TimeOfDay(hour: 18, minute: 0),
      const TimeOfDay(hour: 21, minute: 0),
    ];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: const Text('Book Your Ride'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 1,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(
              () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ===== DATE RANGE =====
              const Text(
                'Select Date Range',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              GestureDetector(
                onTap: () async {
                  await bookingController.selectDateRange();
                  await bookingController.updateUnavailableSlots();
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${bookingController.formatDate(bookingController.startDate.value)} - ${bookingController.formatDate(bookingController.endDate.value)}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      const Icon(Icons.date_range, color: Colors.black54),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),

              // ===== START TIME =====
              const Text(
                'Pick Start Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                children: popularSlots.map((slot) {
                  final selected =
                  isSameTime(slot, bookingController.startTime.value);
                  final unavailable = bookingController.unavailableSlotsStart
                      .any((s) => isSameTime(s, slot));
                  return ChoiceChip(
                    label: Text(
                      slot.format(Get.context!),
                      style: TextStyle(
                        color: unavailable
                            ? Colors.grey[400]
                            : (selected ? Colors.white : Colors.black87),
                      ),
                    ),
                    selected: selected,
                    selectedColor: Colors.black,
                    backgroundColor:
                    unavailable ? Colors.grey[200] : Colors.white,
                    elevation: 2,
                    onSelected: unavailable
                        ? null
                        : (_) async {
                      bookingController.startTime.value = slot;
                      await bookingController.updateUnavailableSlots();
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // ===== END TIME =====
              const Text(
                'Pick End Time',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 10,
                children: popularSlots.map((slot) {
                  final selected =
                  isSameTime(slot, bookingController.endTime.value);
                  final unavailable = bookingController.unavailableSlotsEnd
                      .any((s) => isSameTime(s, slot));
                  return ChoiceChip(
                    label: Text(
                      slot.format(Get.context!),
                      style: TextStyle(
                        color: unavailable
                            ? Colors.grey[400]
                            : (selected ? Colors.white : Colors.black87),
                      ),
                    ),
                    selected: selected,
                    selectedColor: Colors.black,
                    backgroundColor:
                    unavailable ? Colors.grey[200] : Colors.white,
                    elevation: 2,
                    onSelected: unavailable
                        ? null
                        : (_) async {
                      bookingController.endTime.value = slot;
                      await bookingController.updateUnavailableSlots();
                    },
                  );
                }).toList(),
              ),
              const SizedBox(height: 20),

              // ===== AVAILABILITY MESSAGE =====
              Obx(
                    () => Text(
                  bookingController.availabilityMessage.value,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: bookingController.isAvailable.value
                        ? Colors.green
                        : Colors.red,
                  ),
                ),
              ),
              const SizedBox(height: 10),

              SizedBox(height: Get.height*0.14),


              // bottom section total price and proceed to pay
              // total price card
              Align(
                alignment: Alignment.bottomCenter,
                child: Column(
                  children: [
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 12,
                            offset: Offset(0, 6),
                          )
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Total Price',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                          Text(
                            '₹${bookingController.totalPrice().toStringAsFixed(0)}',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // proceed button
                    SizedBox(
                      width: double.infinity,
                      child: Obx(
                            () => ElevatedButton(
                          onPressed: bookingController.isAvailable.value &&
                              !bookingController.isChecking.value
                              ? () async {
                            await bookingController.bookCar();
                            await bookingController.updateUnavailableSlots();
                          }
                              : null,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: bookingController.isAvailable.value
                                ? Colors.black
                                : Colors.grey,
                            padding: const EdgeInsets.symmetric(vertical: 18),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),
                          child: bookingController.isChecking.value
                              ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                              : const Text(
                            'Proceed to Pay',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
