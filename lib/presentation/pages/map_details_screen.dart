import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapDetailsScreen extends StatelessWidget {
  const MapDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
      ),
      body: FlutterMap(
          options: MapOptions(
            initialCenter: LatLng(20.5937, 78.9629),
            initialZoom: 13,



          ),

          children:Text('this happens to be the map')),

    );
  }
}
