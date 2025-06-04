import 'package:flutter/material.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';

class CarDetailsScreen extends StatelessWidget {
  const CarDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.info_outline),
            Text('Information',style: TextStyle(),),

            
          ],
        ),
      ),

      body:Column(
        children: [
          CarCard(car: car)
        ],
      ),
    );
  }
}
