import 'package:flutter/material.dart';
import 'package:rentrover/data/models/Car.dart';
import 'package:rentrover/presentation/pages/map_details_screen.dart';
import 'package:rentrover/presentation/widgets/car_card.dart';
import 'package:rentrover/presentation/widgets/more_card.dart';

class CarDetailsScreen extends StatefulWidget {
  final Car car;
  const CarDetailsScreen({super.key,required this.car});

  @override
  State<CarDetailsScreen> createState() => _CarDetailsScreenState();
}

class _CarDetailsScreenState extends State<CarDetailsScreen> with SingleTickerProviderStateMixin {

  AnimationController? _controller;
  Animation<double>? _animation;


  @override
  void initState() {
    _controller = AnimationController(vsync: this,
    duration: Duration(seconds: 3));


    _animation = Tween<double>(begin: 1.0,end: 1.5).animate(_controller!)..addListener((){
      setState(() {

      });
    });
    _controller!.forward();


    super.initState();
  }
  @override
  void dispose() {
    _controller?.dispose();
    // TODO: implement dispose
    super.dispose();
  }

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
          CarCard(car : Car(model: widget.car.model, distance: widget.car.distance , fuelCapacity: widget.car.fuelCapacity , pricePerHour: widget.car.pricePerHour),),
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
                        child: Transform.scale(
                          scale: _animation!.value,
                            alignment: Alignment.center,
                            child: Image.asset('assets/maps.png',fit: BoxFit.cover,)),
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
                    child: MoreCard(car: Car(model: widget.car.model+ "-1", distance: widget.car.distance+100 , fuelCapacity: widget.car.fuelCapacity +100, pricePerHour: widget.car.pricePerHour+10))),
                Container(
                  margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child: MoreCard(car: Car(model: widget.car.model+ "-2", distance: widget.car.distance+200 , fuelCapacity: widget.car.fuelCapacity +200, pricePerHour: widget.car.pricePerHour+20),)),
                Container(
                  margin: EdgeInsets.only(top: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18)
                    ),
                    child: MoreCard(car: Car(model: widget.car.model + "-3", distance: widget.car.distance +300, fuelCapacity: widget.car.fuelCapacity+300 , pricePerHour: widget.car.pricePerHour+30),)),

              ],
            ),
          )


        ],
      ),
    );
  }
}
