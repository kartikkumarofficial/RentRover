import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentrover/data/models/Car.dart';
import 'package:rentrover/domain/usecases/get_cars.dart';




class FirebaseCarDataSource{
  final FirebaseFirestore firestore;
  FirebaseCarDataSource({required this.firestore});

  Future<List<Car>> GetCars() async {
    var snapshot =  await firestore.collection('cars').get();
    return snapshot.docs.map((doc)=> Car.FromMap(doc.data())).toList();

  }
}