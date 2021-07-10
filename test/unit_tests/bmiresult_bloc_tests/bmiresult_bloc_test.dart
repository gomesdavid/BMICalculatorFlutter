import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator/screens/result/bloc/bmiresult_bloc.dart';

void main() {
  BmiResultBloc bloc;
  final _initialState = BmiresultInitial();

  setUp(() {
    bloc = BmiResultBloc();
  });

  group('states', () {
    test('initial state is correct', () async {
      expect(bloc.state, _initialState);
    });

    blocTest<BmiResultBloc, BmiresultState>(
      'emits [BmiPageLoaded] when CalculateBMIButtonPressed is added.',
      build: () => bloc,
      act: (bloc) =>
          bloc.add(CalculateBMIButtonPressed(height: 170, weight: 50)),
      seed: () => _initialState,
      expect: () => [
        BmiPageLoaded(
          bmiInterpretation:
              'You have a lower than normal body weight. You can eat a bit more.',
          bmiResult: 17.301038062283737,
          bmiResultText: 'Underweight',
        )
      ],
    );
  });
}
