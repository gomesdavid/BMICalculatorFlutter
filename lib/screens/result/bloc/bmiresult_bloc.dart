import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'bmiresult_event.dart';
part 'bmiresult_state.dart';

class BmiResultBloc extends Bloc<BmiresultEvent, BmiresultState> {
  BmiResultBloc() : super(BmiresultInitial());

  @override
  Stream<BmiresultState> mapEventToState(
    BmiresultEvent event,
  ) async* {
    if (event is CalculateBMIButtonPressed) {
      yield* calculateBmiToState(event.height, event.weight);
    }
  }

  Stream<BmiresultState> calculateBmiToState(int height, int weight) async* {
    final bmi = _calculateBMI(height, weight);
    final resultText = _getResult(bmi);
    final interpretation = _getInterpretation(bmi);

    yield BmiPageLoaded(
      bmiResult: bmi,
      bmiInterpretation: interpretation,
      bmiResultText: resultText,
    );
  }

  double _calculateBMI(int height, int weight) {
    final _bmi = weight / pow(height / 100, 2);
    return _bmi;

    //male weight(kg)/ (height)x(height)
    //female  weight/square of height
  }

  String _getResult(double bmi) {
    if (bmi >= 25) {
      return 'Overweight';
    } else if (bmi > 18.5) {
      return 'Normal';
    } else {
      return 'Underweight';
    }
  }

  String _getInterpretation(double bmi) {
    if (bmi >= 25) {
      return 'You have a higher than normal body weight. Try to exercise more.';
    } else if (bmi > 18.5) {
      return 'You have a normal body weight. Good job!';
    } else {
      return 'You have a lower than normal body weight. You can eat a bit more.';
    }
  }
}
