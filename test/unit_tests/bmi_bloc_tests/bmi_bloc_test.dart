import 'package:bmi_calculator/screens/input_page/models/gender.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator/screens/input_page/bloc/bmi_bloc.dart';

void main() {
  BmiBloc bloc;
  final _initialState = BmiInitial();
  final _ageIncreasedState =
      BmiAgeChanged(age: 21, currentState: _initialState);

  setUp(() {
    bloc = BmiBloc();
  });

  group('states', () {
    test('initial state is correct', () async {
      expect(bloc.state, _initialState);
    });

    blocTest<BmiBloc, BmiState>(
      'emits [LoadingProcess, BmiGenderChanged] when GenderMaleButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(GenderMaleButtonPressed()),
      seed: () => _initialState,
      expect: () => [
        BmiLoadingProcess(),
        BmiGenderChanged(
          gender: Gender.male,
          currentState: BmiInitial(),
        ),
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [LoadingProcess, BmiGenderChanged] when GenderFemaleButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(GenderFemaleButtonPressed()),
      seed: () => _initialState,
      expect: () => [
        BmiLoadingProcess(),
        BmiGenderChanged(
          gender: Gender.female,
          currentState: BmiInitial(),
        ),
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [BmiAgeChanged] when AgeIncrementButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(AgeIncrementButtonPressed()),
      seed: () => _initialState,
      expect: () => [
        BmiAgeChanged(age: 21, currentState: _initialState),
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [BmiAgeChanged] with age 22 when AgeIncrementButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(AgeIncrementButtonPressed()),
      seed: () => _ageIncreasedState,
      expect: () => [
        BmiAgeChanged(age: 22, currentState: _ageIncreasedState),
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [BmiAgeChanged] when AgeDecrementButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(AgeDecrementButtonPressed()),
      seed: () => _initialState,
      expect: () => [
        BmiAgeChanged(age: 19, currentState: _initialState),
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [BmiHeightChanged] when HeightSliderChanged is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(HeightSliderChanged(180)),
      seed: () => _initialState,
      expect: () => [
        BmiHeightChanged(
          height: 180,
          currentState: _initialState,
        )
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [BmiWeightChanged] when WeightIncrementButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(WeightIncrementButtonPressed()),
      seed: () => _initialState,
      expect: () => [
        BmiWeightChanged(weight: 76, currentState: _initialState),
      ],
    );

    blocTest<BmiBloc, BmiState>(
      'emits [BmiWeightChanged] when WeightDecrementButtonPressed is added.',
      build: () => bloc,
      act: (bloc) => bloc.add(WeightDecrementButtonPressed()),
      seed: () => _initialState,
      expect: () => [
        BmiWeightChanged(weight: 74, currentState: _initialState),
      ],
    );
  });
}
