import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:rentrover/data/models/car_model.dart';

class BookingController extends GetxController {
  final SupabaseClient supabase = Supabase.instance.client;
  final CarModel car;

  BookingController(this.car);
  var unavailableSlotsStart = <TimeOfDay>[].obs;
  var unavailableSlotsEnd = <TimeOfDay>[].obs;
  var availabilityMessage = ''.obs;
  final startDate = DateTime.now().obs;
  final endDate = DateTime.now().add(const Duration(days: 1)).obs;
  final startTime = TimeOfDay(hour: 9, minute: 0).obs;
  final endTime = TimeOfDay(hour: 18, minute: 0).obs;

  final isChecking = false.obs;
  final isAvailable = true.obs;


// Call this whenever date/time changes
  Future<void> updateUnavailableSlots() async {
    unavailableSlotsStart.clear();
    unavailableSlotsEnd.clear();

    // Fetch overlapping bookings from Supabase
    final from = DateTime(startDate.value.year, startDate.value.month, startDate.value.day);
    final to = DateTime(endDate.value.year, endDate.value.month, endDate.value.day, 23, 59);

    final bookings = await supabase
        .from('bookings')
        .select()
        .eq('car_id', car.id)
        .lt('start_time', to.toIso8601String())
        .gt('end_time', from.toIso8601String());

    if (bookings.isEmpty) {
      availabilityMessage.value = 'Available';
      isAvailable.value = true;
      return;
    }

    // disabling slots that overlap
    for (var b in bookings) {
      final bookedStart = DateTime.parse(b['start_time']);
      final bookedEnd = DateTime.parse(b['end_time']);

      for (var slot in [
        const TimeOfDay(hour: 9, minute: 0),
        const TimeOfDay(hour: 12, minute: 0),
        const TimeOfDay(hour: 15, minute: 0),
        const TimeOfDay(hour: 18, minute: 0),
        const TimeOfDay(hour: 21, minute: 0),
      ]) {
        final slotDateTimeStart = DateTime(
          startDate.value.year,
          startDate.value.month,
          startDate.value.day,
          slot.hour,
          slot.minute,
        );

        if (!slotDateTimeStart.isBefore(bookedStart) && slotDateTimeStart.isBefore(bookedEnd)) {
          unavailableSlotsStart.add(slot);
          unavailableSlotsEnd.add(slot);
        }
      }
    }

    isAvailable.value = unavailableSlotsStart.isEmpty;
    availabilityMessage.value = isAvailable.value ? 'Available' : 'Some slots unavailable';
  }

  String formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy').format(date);
  }
  Future<void> selectDateRange() async {
    final picked = await showDateRangePicker(
      context: Get.context!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      barrierColor: Colors.black.withAlpha(50),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Colors.black, // header background color
              onPrimary: Colors.white, // header text color
              onSurface: Colors.black, // dates text color
              surface: Colors.white, // picker background
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: Colors.black, // buttons color (CANCEL, OK)
              ),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      startDate.value = picked.start;
      endDate.value = picked.end;
      startTime.value = const TimeOfDay(hour: 9, minute: 0);
      endTime.value = const TimeOfDay(hour: 18, minute: 0);
      await checkAvailability();
    }
  }


  Future<void> selectTime(bool isStart) async {
    final picked = await showTimePicker(
      context: Get.context!,
      initialTime: isStart ? startTime.value : endTime.value,
    );

    if (picked != null) {
      if (isStart) {
        startTime.value = picked;
      } else {
        endTime.value = picked;
      }
      await checkAvailability();
    }
  }

  double totalPrice() {
    final from = DateTime(
      startDate.value.year,
      startDate.value.month,
      startDate.value.day,
      startTime.value.hour,
      startTime.value.minute,
    );
    final to = DateTime(
      endDate.value.year,
      endDate.value.month,
      endDate.value.day,
      endTime.value.hour,
      endTime.value.minute,
    );
    final duration = to.difference(from);
    int days = (duration.inHours / 24).ceil();
    return car.pricePerDay * days;
  }

  Future<bool> checkAvailability() async {
    isChecking.value = true;

    final from = DateTime(
      startDate.value.year,
      startDate.value.month,
      startDate.value.day,
      startTime.value.hour,
      startTime.value.minute,
    );

    final to = DateTime(
      endDate.value.year,
      endDate.value.month,
      endDate.value.day,
      endTime.value.hour,
      endTime.value.minute,
    );

    try {
      final response = await supabase
          .from('bookings')
          .select()
          .eq('car_id', car.id)
          .lt('start_time', to.toIso8601String())
          .gt('end_time', from.toIso8601String());

      isChecking.value = false;
      isAvailable.value = response.isEmpty;
      availabilityMessage.value = response.isEmpty
          ? 'Available'
          : 'Unavailable for selected time';
      return response.isEmpty;
    } catch (e) {
      isChecking.value = false;
      availabilityMessage.value = 'Error checking availability';
      return false;
    }
  }

  Future<void> bookCar() async {
    final from = DateTime(
      startDate.value.year,
      startDate.value.month,
      startDate.value.day,
      startTime.value.hour,
      startTime.value.minute,
    );

    final to = DateTime(
      endDate.value.year,
      endDate.value.month,
      endDate.value.day,
      endTime.value.hour,
      endTime.value.minute,
    );

    final available = await checkAvailability();

    if (!available) {
      Get.snackbar(
        'Unavailable',
        'This car is already booked for the selected time.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red.shade100,
        colorText: Colors.red.shade900,
      );
      return;
    }

    try {
      await supabase.from('bookings').insert({
        'car_id': car.id,
        'user_id': supabase.auth.currentUser!.id,
        'start_time': from.toIso8601String(),
        'end_time': to.toIso8601String(),
        'status': 'confirmed',
      });

      Get.snackbar('Success', 'Your car has been booked!',
          snackPosition: SnackPosition.TOP);
      await checkAvailability(); // refresh availability after booking
    } catch (e) {
      Get.snackbar('Booking Error', 'Something went wrong while booking: $e',
          snackPosition: SnackPosition.TOP);
    }
  }
}

