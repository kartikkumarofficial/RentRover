  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:google_fonts/google_fonts.dart';
  import 'package:rentrover/controllers/car_controller.dart';
  import 'package:rentrover/data/models/car_model.dart';
  import 'package:rentrover/presentation/screens/booking_screen.dart';
  import 'package:rentrover/presentation/screens/map_details_screen.dart';
  import 'package:rentrover/presentation/widgets/car_card.dart';
  import 'package:rentrover/presentation/widgets/more_card.dart';

  class CarDetailsScreen extends StatefulWidget {
    final CarModel car;

    const CarDetailsScreen({super.key, required this.car});

    @override
    State<CarDetailsScreen> createState() => _CarDetailsScreenState();
  }

  class _CarDetailsScreenState extends State<CarDetailsScreen> with SingleTickerProviderStateMixin {

    AnimationController? _controller;
    Animation<double>? _animation;


    @override
    void initState() {
      super.initState();

      _controller = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 3),
      );

      _animation = Tween<double>(begin: 1.0, end: 1.5).animate(_controller!)
        ..addListener(() {
          setState(() {});
        });

      _controller!.forward();
    }

    @override
    void dispose() {
      _controller?.dispose();
      super.dispose();
    }

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        
        body: SafeArea(
          child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // SizedBox(width: Get.width*0.11),
                    const Icon(Icons.info_outline),
                    const SizedBox(width: 8),
                    Text('Information',style: GoogleFonts.playfairDisplay(fontSize: 25),),
                  ],
                ),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 6),
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
          
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          widget.car.imageUrl,
                          height: 130,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),
          
                      const SizedBox(height: 12),
          
          
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            widget.car.name,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          Text(textAlign: TextAlign.end,
                            '₹${widget.car.pricePerDay.toStringAsFixed(0)}/day',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurpleAccent,
                            ),
                          ),
                        ],
                      ),
          
          
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xffF3F3F3),
                            borderRadius: BorderRadius.circular(20),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                          child: Column(
                            children: const [
                              CircleAvatar(
                                radius: 40,
                                backgroundImage: AssetImage('assets/user.png'),
                              ),
                              SizedBox(height: 10),
                              Text('Jane Cooper', style: TextStyle(fontWeight: FontWeight.bold)),
                              Text('\$4,253', style: TextStyle(color: Colors.grey)),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => MapDetailsScreen(car: widget.car)),
                            );
                          },
                          child: Container(
                            height: 170,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 10,
                                  spreadRadius: 5,
                                )
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Transform.scale(
                                scale: _animation!.value,
                                alignment: Alignment.center,
                                child: Image.asset('assets/maps.png', fit: BoxFit.cover),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Add this inside your build method, below the existing Row (with user + map)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xffF3F3F3),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 10,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Description',
                              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              widget.car.description,
                              style: const TextStyle(fontSize: 14, color: Colors.black87),
                            ),
                          ],
                        ),
                      ),
          
                      const SizedBox(height: 20),
          
          
          
          
                      Wrap(
                        crossAxisAlignment:WrapCrossAlignment.end,
                        spacing: 20,
                        runSpacing: 12,
                        children: [
                          _featureTile(Icons.settings, "Transmission", widget.car.transmission),
                          _featureTile(Icons.local_gas_station, "Fuel", "${widget.car.fuelCapacity} L"),
                          _featureTile(Icons.event_seat, "Seats", "${widget.car.seats}"),
                          _featureTile(Icons.place, "Location", widget.car.location),
                          _featureTile(Icons.currency_rupee, "Per Day", "₹${widget.car.pricePerDay.toStringAsFixed(0)}"),
                          _featureTile(Icons.currency_rupee, "Per Day", "₹${widget.car.pricePerDay.toStringAsFixed(0)}"),
                        ],
                      ),
                      SizedBox(height:Get.height*0.11),
                    ],
                  ),
                ),
          
          
              ],
            ),
          ),
        ),
        floatingActionButton: Container(
          width: Get.width * 0.9,
          margin: const EdgeInsets.only(bottom: 16),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
              backgroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            onPressed: () {
              Get.to(BookingPage(carId: widget.car.id));
            },
            child: const Text(
              "Book Now",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold,color: Colors.white),
            ),
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      );
    }
  }

  Widget _featureTile(IconData icon, String label, String value) {
    return Container(
      width: Get.width * 0.4,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xffF9F9F9),
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            spreadRadius: 3,
          )
        ],
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black, size: 22),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          )
        ],
      ),
    );
  }
