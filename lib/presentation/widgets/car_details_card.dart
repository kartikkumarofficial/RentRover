import 'package:flutter/material.dart';
import 'package:rentrover/data/models/car.dart';
import 'package:rentrover/presentation/widgets/feature_icons.dart';


Widget carDetailsCard({required Car car}) {
  return SizedBox(
    height: 350,
    child: Stack(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          width: double.infinity,
          decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10)
              ]
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text('${car.model}', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Icon(Icons.directions_car, color: Colors.white, size: 16,),
                  SizedBox(width: 5,),
                  Text(
                    '> ${car.distance} km',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(width: 10,),
                  Icon(Icons.battery_full, color: Colors.white, size: 14,),
                  SizedBox(width: 5,),
                  Text(
                    '${car.fuelCapacity.toString()}',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              )
            ],
          ),
        ),

        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  topLeft: Radius.circular(20),
                )
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Features", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),),
                featureIcons(),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${car.pricePerHour}/day', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                    ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.black),
                        child: Text('Book Now', style: TextStyle(color: Colors.white),)
                    )
                  ],
                )
              ],
            ),
          ),
        ),

        Positioned(
            top: 50,
            right: 20,
            child: Image.asset('assets/white_car.png')
        )
      ],
    ),
  );
}




