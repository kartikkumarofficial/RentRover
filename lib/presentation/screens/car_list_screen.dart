import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rentrover/controllers/car_controller.dart';
import 'package:rentrover/controllers/user_controller.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';
import 'package:rentrover/controllers/auth_controller.dart';

class CarListScreen extends StatelessWidget {
  CarListScreen({super.key});

  final CarController carController = Get.put(CarController());
  final AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    final String username = authController.nameController.text.trim();

    return Scaffold(

      body: RefreshIndicator(
        onRefresh :()=>  carController.fetchCars() ,
        child: SafeArea(
          child: Obx(() {
            if (carController.isLoading.value) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hi, ${username.isNotEmpty ? username :username} 👋', // fixx this
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 6),
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


                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 0),
                    itemCount: carController.cars.length,
                    itemBuilder: (context, index) {
                      return CarCard(car: carController.cars[index]);
                    },
                  ),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}
