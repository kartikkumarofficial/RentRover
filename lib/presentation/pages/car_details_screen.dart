import 'package:flutter/material.dart';
import 'package:rentrover/data/models/Car.dart';
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
          CarCard(car : Car(model: "Fortuner GR", distance: 870, fuelCapacity: 50, pricePerHour: 45),),
          SizedBox(height: 20,),
          Container(
            decoration: BoxDecoration(
              color: Color(0xffF3F3F3),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [ BoxShadow(
                color: Colors.black12,
                blurRadius: 10,
                spreadRadius: 5,
              ),]
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/user.png'),
                ),
                SizedBox(height: 10,),
                Text('Jane Cooper',style: TextStyle(fontWeight: FontWeight.bold),),
                Text('\$4,253',style: TextStyle(color: Colors.grey),),
              ],
            ),
          )

        ],
      ),
    );
  }
}
