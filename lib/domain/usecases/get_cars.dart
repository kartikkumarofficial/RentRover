import 'package:flutter/material.dart';
import 'package:rentrover/data/models/Car.dart';
import 'package:rentrover/domain/repositories/car_repository.dart';

class GetCars{
  final CarRepository repository;

  GetCars(this.repository);

  Future<List<Car>> call() async{
    return await repository.fetchCars() ;
  }

}