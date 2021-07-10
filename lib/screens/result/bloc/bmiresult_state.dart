part of 'bmiresult_bloc.dart';

abstract class BmiresultState extends Equatable {
  @override
  List<Object> get props => [];
}

class BmiresultInitial extends BmiresultState {}

class BmiPageLoaded extends BmiresultState {
  final String bmiResultText;
  final String bmiInterpretation;
  final double bmiResult;

  BmiPageLoaded({
    @required this.bmiResultText,
    @required this.bmiInterpretation,
    @required this.bmiResult,
  });

  @override
  List<Object> get props => [bmiResultText, bmiResult, bmiInterpretation];
}
