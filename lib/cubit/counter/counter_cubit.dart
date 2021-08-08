import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import '../color/color_cubit.dart';

part 'counter_state.dart';

class CounterCubit extends Cubit<CounterState> {
  int incrementStep = 1;
  StreamSubscription? counterSubscription;

  final ColorCubit colorCubit;
  CounterCubit({required this.colorCubit}) : super(CounterState.initial()) {
    counterSubscription = colorCubit.stream.listen((ColorState colorState) {
      if (colorState.color == Colors.red) {
        incrementStep = 1;
      } else if (colorState.color == Colors.green) {
        incrementStep = 10;
      } else if (colorState.color == Colors.blue) {
        incrementStep = 100;
      } else if (colorState.color == Colors.black) {
        emit(state.copyWith(counter: state.counter - 100));
        incrementStep = -100;
      }
    });
  }

  @override
  Future<void> close() {
    counterSubscription?.cancel();
    return super.close();
  }

  void changeCounter() {
    emit(state.copyWith(counter: state.counter + incrementStep));
  }
}
