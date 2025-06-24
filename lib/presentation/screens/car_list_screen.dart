import 'package:flutter/material.dart';
import 'package:rentrover/controllers/car_controller.dart';
import 'package:get/get.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {
  CarListScreen({super.key});

  final CarController carController = Get.put(CarController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Choose Your Car"),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0.5,
      ),
      body: Obx(() {
        if (carController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          itemCount: carController.cars.length,
          itemBuilder: (context, index) {
            return CarCard(car: carController.cars[index]);
          },
        );
      }),
    );
  }
}
