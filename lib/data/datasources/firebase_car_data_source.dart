import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rentrover/data/models/car.dart';
import 'package:rentrover/domain/usecases/get_cars.dart';




class FirebaseCarDataSource{
  final FirebaseFirestore firestore;
  FirebaseCarDataSource({required this.firestore});

  Future<List<Car>> getCars() async {
    var snapshot =  await firestore.collection('cars').get();
    return snapshot.docs.map((doc)=> Car.fromMap(doc.data())).toList();

  }
}