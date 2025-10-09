import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:rentrover/data/models/car_model.dart';
import 'package:rentrover/presentation/widgets/car_details_card.dart';

class MapDetailsScreen extends StatefulWidget {
  final CarModel car;

  const MapDetailsScreen({super.key, required this.car});

  @override
  State<MapDetailsScreen> createState() => _MapDetailsScreenState();
}

class _MapDetailsScreenState extends State<MapDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // Create a repeating animation between 1.0 and 1.2 scale
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 1.0, end: 1.2)
        .animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final car = widget.car;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(Icons.arrow_back, size: 28),
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(car.latitude, car.longitude),
              initialZoom: 14,
            ),
            children: [
              TileLayer(
                urlTemplate: "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                userAgentPackageName: 'com.example.rentrover',
              ),
              MarkerLayer(
                markers: [
                  Marker(
                    point: LatLng(car.latitude, car.longitude),
                    width: 60,
                    height: 60,
                    child: AnimatedBuilder(
                      animation: _animation,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: _animation.value,
                          child: child,
                        );
                      },
                      child: SizedBox(
                        height: 10,
                        width: 10,
                        child: CircleAvatar(

                          // radius: 1,
                          maxRadius: 5,
                          backgroundColor: Colors.white.withAlpha(96),
                          child: Icon(
                            CupertinoIcons.car,
                            color: Colors.black,
                            size: 40,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Bottom details card
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: carDetailsCard(car: car),
          ),
        ],
      ),
    );
  }
}
