import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CurrentBookingsController extends GetxController {
  final bookings = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookings();
  }

  Future<void> fetchBookings() async {
    isLoading.value = true;
    try {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      final response = await Supabase.instance.client
          .from('bookings')
          .select('''
          *,
          cars (
            name,
            images,
            price_per_day
          )
        ''')
          .eq('user_id', userId)
          .gte('end_time', DateTime.now().toIso8601String())
          .order('start_time', ascending: true);

      bookings.assignAll(response);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
