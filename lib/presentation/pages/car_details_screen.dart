import 'package:flutter/material.dart';
import 'package:rentrover/data/models/Car.dart';
import 'package:rentrover/presentation/pages/map_details_screen.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';
import 'package:rentrover/presentation/widgets/more_card.dart';

class CarDetailsScreen extends StatelessWidget {
  final Car car;
  const CarDetailsScreen({super.key,required this.car});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 60,),
            Icon(Icons.info_outline),
            Text('Information',style: TextStyle(),),


          ],
        ),
      ),

      body:Column(
        children: [
          CarCard(car : Car(model: car.model, distance: car.distance , fuelCapacity: car.fuelCapacity , pricePerHour: car.pricePerHour),),
          SizedBox(height: 20,),
          Padding(
            padding:  EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              children: [
                Expanded(

                  child: Container(
                    padding: EdgeInsets.all(20),
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
                  ),
                ),
                SizedBox(width: 20,),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      Navigator.of(context).push(MaterialPageRoute(builder:
                      (context) => MapDetailsScreen(),));
                    },
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 5
                            )
                          ]
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('assets/maps.png',fit: BoxFit.cover,),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child: MoreCard(car: Car(model: car.model+ "-1", distance: car.distance+100 , fuelCapacity: car.fuelCapacity +100, pricePerHour: car.pricePerHour+10))),
                Container(
                  margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child: MoreCard(car: Car(model: car.model+ "-2", distance: car.distance+200 , fuelCapacity: car.fuelCapacity +200, pricePerHour: car.pricePerHour+20),)),
                Container(
                  margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child: MoreCard(car: Car(model: car.model + "-3", distance: car.distance +300, fuelCapacity: car.fuelCapacity+300 , pricePerHour: car.pricePerHour+30),)),

              ],
            ),
          )


        ],
      ),
    );
  }
}
