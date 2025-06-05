import 'package:flutter/material.dart';
import 'package:rentrover/data/datasources/firebase_car_data_source.dart';
import 'package:rentrover/data/models/car.dart';
import 'package:rentrover/domain/repositories/car_repository.dart';
import 'package:rentrover/domain/usecases/get_cars.dart';


class CarRepositoryImpl implements CarRepository {
  final FirebaseCarDataSource dataSource;

  CarRepositoryImpl(this.dataSource);

  @override
  Future<List<Car>> fetchCars() {
    return dataSource.getCars();

  }

}