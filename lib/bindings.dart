import 'package:get/get.dart';
import 'package:rentrover/controllers/currentbooking_controller.dart';
import 'controllers/auth_controller.dart';
import 'controllers/user_controller.dart';

class InitialBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController());
    Get.put(UserController(),permanent: true);
    Get.put(CurrentBookingsController(),permanent: true);
  }
}
