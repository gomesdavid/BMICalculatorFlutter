part of 'bmi_bloc.dart';

@immutable
abstract class BmiState extends Equatable {
  final Gender gender;
  final int height;
  final int weight;
  final int age;

  BmiState({
    this.gender,
    this.height,
    this.age,
    this.weight,
  });

  @override
  List<Object> get props => [gender, height, weight, age];
}

class BmiInitial extends BmiState {
  BmiInitial()
      : super(
          gender: null,
          height: 180,
          weight: 75,
          age: 20,
        );
}

class BmiGenderChanged extends BmiState {
  final Gender gender;
  final BmiState currentState;
  BmiGenderChanged({
    @required this.gender,
    @required this.currentState,
  }) : super(
          gender: gender,
          height: currentState.height,
          weight: currentState.weight,
          age: currentState.age,
        );

  @override
  List<Object> get props => [gender, currentState];
}

class BmiHeightChanged extends BmiState {
  final int height;
  final BmiState currentState;
  BmiHeightChanged({this.height, this.currentState})
      : super(
          height: height,
          gender: currentState.gender,
          weight: currentState.weight,
          age: currentState.age,
        );

  @override
  List<Object> get props => [height, currentState];
}

class BmiWeightChanged extends BmiState {
  final int weight;
  final BmiState currentState;
  BmiWeightChanged({this.weight, this.currentState})
      : super(
          weight: weight,
          gender: currentState.gender,
          height: currentState.height,
          age: currentState.age,
        );

  @override
  List<Object> get props => [weight, currentState];
}

class BmiAgeChanged extends BmiState {
  final int age;
  final BmiState currentState;
  BmiAgeChanged({this.age, this.currentState})
      : super(
          age: age,
          gender: currentState.gender,
          height: currentState.height,
          weight: currentState.weight,
        );

  @override
  List<Object> get props => [age, currentState];
}

class BmiLoadingProcess extends BmiState {}
