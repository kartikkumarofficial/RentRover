import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rentrover/data/models/car_model.dart';
import 'package:rentrover/presentation/screens/booking_screen.dart';
import 'package:rentrover/presentation/widgets/feature_icons.dart';

Widget carDetailsCard({required CarModel car}) {
  return SizedBox(
    height: Get.height * 0.49,
    child: Stack(
      clipBehavior: Clip.none,
      children: [
       //transparent
        Positioned(
          top: 60,
          left: 0,
          right: 0,
          child: Container(
            height: Get.height * 0.25,
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha:0.5),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black38,
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                SizedBox(
                  width: Get.width * 0.44, // adjust as needed
                  child: Text(
                    car.name.split(' ').take(2).join(' '),
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                    Text(
                      car.location,
                      style: GoogleFonts.barlow(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Icon(Icons.battery_charging_full,
                        color: Colors.white, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      '${car.fuelCapacity} L',
                      style: GoogleFonts.barlow(
                        color: Colors.white,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        // white
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: Container(
            height: Get.height*0.3,
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10,
                )
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Features",
                  style: GoogleFonts.barlow(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 10),
                featureIcons(),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '₹${car.pricePerDay.toStringAsFixed(0)}/day',
                      style: GoogleFonts.barlow(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        Get.to(BookingPage(car: car));

                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: Text(
                        'Book Now',
                        style: GoogleFonts.barlow(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),

 //image overlay
        Positioned(
          top: 20,
          right: 0,
          child: Image.asset(
            'assets/white_car.png',
            height: 130,
            fit: BoxFit.contain,
          ),
        ),
      ],
    ),
  );
}
