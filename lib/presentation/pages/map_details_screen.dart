import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentrover/data/models/Car.dart';
import 'package:rentrover/presentation/widgets/car_details_card.dart';

class MapDetailsScreen extends StatelessWidget {
  const MapDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(onPressed: (){
          Navigator.pop(context);
        }, icon: Padding(
          padding:  EdgeInsets.all(8.0),
          child: Icon(Icons.arrow_back,size:28,),
        )),
        backgroundColor: Colors.transparent,
      ),
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                // initialCenter: LatLng(20.5937, 78.9629),
                initialCenter: LatLng(30.3165, 78.0322), //ddun
                initialZoom: 13,
              ),

              children: [
                TileLayer(
                  urlTemplate:
                  "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
                  subdomains: ['a', 'b', 'c'],
                  userAgentPackageName: 'com.example.rentrover',
                ),
              ],

          ),
          Positioned(
            bottom: 0,
              left: 0,
              right: 0,

              child:carDetailsCard(car:Car(model: "Fortuner GR", distance: 870, fuelCapacity: 50, pricePerHour: 45), ))
        ],
      ),

    );
  }
}
