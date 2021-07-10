import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bmi_calculator/screens/input_page/models/gender.dart';
import 'package:meta/meta.dart';
import 'package:equatable/equatable.dart';

part 'bmi_event.dart';
part 'bmi_state.dart';

class BmiBloc extends Bloc<BmiEvent, BmiState> {
  BmiBloc() : super(BmiInitial());

  @override
  Stream<BmiState> mapEventToState(
    BmiEvent event,
  ) async* {
    if (event is GenderMaleButtonPressed) {
      yield* _genderChangedToState(Gender.male);
    } else if (event is GenderFemaleButtonPressed) {
      yield* _genderChangedToState(Gender.female);
    } else if (event is HeightSliderChanged) {
      yield* _heightChangedToState(event.value);
    } else if (event is WeightIncrementButtonPressed) {
      yield* weightChangedToState(state.weight + 1);
    } else if (event is WeightDecrementButtonPressed) {
      yield* weightChangedToState(state.weight - 1);
    } else if (event is AgeIncrementButtonPressed) {
      yield* ageChangeToState(state.age + 1);
    } else if (event is AgeDecrementButtonPressed) {
      yield* ageChangeToState(state.age - 1);
    }
  }

  Stream<BmiState> _genderChangedToState(Gender gender) async* {
    final temp = state;
    yield BmiLoadingProcess();
    await Future.delayed(Duration(seconds: 1)); //wait 1 seconds
    yield BmiGenderChanged(gender: gender, currentState: temp);
  }

  Stream<BmiState> _heightChangedToState(int value) async* {
    yield BmiHeightChanged(height: value, currentState: state);
  }

  Stream<BmiState> weightChangedToState(int weight) async* {
    yield BmiWeightChanged(weight: weight, currentState: state);
  }

  Stream<BmiState> ageChangeToState(int age) async* {
    yield BmiAgeChanged(age: age, currentState: state);
  }
}
