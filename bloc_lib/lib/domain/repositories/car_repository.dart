import 'package:flutter/material.dart';
import 'package:rentrover/data/models/car.dart';


abstract class CarRepository{
  Future<List<Car>> fetchCars();
  }
