import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentrover/controllers/car_controller.dart';
import 'package:rentrover/controllers/user_controller.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';
import 'package:rentrover/controllers/auth_controller.dart';

class CarListScreen extends StatefulWidget {
  CarListScreen({super.key});

  @override
  State<CarListScreen> createState() => _CarListScreenState();
}

class _CarListScreenState extends State<CarListScreen> {
  final CarController carController = Get.put(CarController());

  final AuthController authController = Get.find<AuthController>();

  final UserController userController = Get.find<UserController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userController.fetchUserProfile();
  }
  @override
  Widget build(BuildContext context) {

    final String username = userController.userName.trim();

    return Scaffold(

      body: RefreshIndicator(
        onRefresh :()=>  carController.fetchCars() ,
        child: Obx(() {
          if (carController.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: Get.height*0.03,),




              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 0),
                  itemCount: carController.cars.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Hey, ${userController.userName.value.isNotEmpty
                              ? userController.userName.value
                                  : 'Guest User'} 👋',
                                    style: GoogleFonts.inter(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  const Text(
                                    'Ready for your next ride?',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            CarCard(car: carController.cars[index]), // show first card too
                          ],
                        );
                      } else {
                        return CarCard(car: carController.cars[index]);
                      }
                    }

                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
