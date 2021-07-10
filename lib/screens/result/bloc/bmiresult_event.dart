part of 'bmiresult_bloc.dart';

abstract class BmiresultEvent extends Equatable {}

class CalculateBMIButtonPressed extends BmiresultEvent {
  final int height;
  final int weight;

  CalculateBMIButtonPressed({@required this.height, @required this.weight});

  @override
  List<Object> get props => [height, weight];
}
