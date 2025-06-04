import 'package:flutter/material.dart';
import 'package:rentrover/data/models/Car.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {
   CarListScreen({super.key});
  final List<Car> cars=[
    Car(model: "Fortuner GR", distance: 870, fuelCapacity: 50, pricePerHour: 45),
    Car(model: "Fortuner GR", distance: 870, fuelCapacity: 50, pricePerHour: 45),
    Car(model: "Fortuner GR", distance: 870, fuelCapacity: 50, pricePerHour: 45),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          
        title: Row(mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Choose your Car",  //todo style text
            style: TextStyle(),),
          ],
        ),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body:ListView.builder(
        itemCount: cars.length,
          itemBuilder: (context, index) {
            return CarCard(car: cars[index]);
          } ,),
    );
  }
}
