import 'package:flutter/cupertino.dart';
import 'package:rentrover/data/models/car.dart';
import 'package:rentrover/domain/usecases/get_cars.dart';

import 'car_event.dart';
import 'car_state.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentrover/domain/usecases/get_cars.dart';

class CarBloc extends Bloc<CarEvent, CarState>{

  final GetCars getCars;

  CarBloc({required this.getCars}) : super(CarsLoading()){

    on <LoadCars>((event,emit) async {
      emit(CarsLoading());
      try{
        final cars = await getCars.call();
        emit(CarsLoaded(cars));
      }catch(e){
        emit(CarsError(e.toString()));
      }

    });
  }
}