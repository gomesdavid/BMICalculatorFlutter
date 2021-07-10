part of 'bmi_bloc.dart';

@immutable
abstract class BmiEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GenderMaleButtonPressed extends BmiEvent {}

class GenderFemaleButtonPressed extends BmiEvent {}

class HeightSliderChanged extends BmiEvent {
  final int value;
  HeightSliderChanged(this.value);

  @override
  List<Object> get props => [value];
}

class WeightIncrementButtonPressed extends BmiEvent {}

class WeightDecrementButtonPressed extends BmiEvent {}

class AgeIncrementButtonPressed extends BmiEvent {}

class AgeDecrementButtonPressed extends BmiEvent {}
