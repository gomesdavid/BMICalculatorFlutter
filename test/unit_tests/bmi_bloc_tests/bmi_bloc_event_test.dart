import 'package:bmi_calculator/screens/input_page/bloc/bmi_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('props', () {
    test('GenderMaleButtonPressed', () {
      expect(GenderMaleButtonPressed().props, []);
    });

    test('GenderFemaleButtonPressed', () {
      expect(GenderFemaleButtonPressed().props, []);
    });

    test('HeightSliderChanged', () {
      expect(
        HeightSliderChanged(175).props,
        [175],
      );
    });

    test('WeightIncrementButtonPressed', () {
      expect(WeightIncrementButtonPressed().props, []);
    });

    test('WeightDecrementButtonPressed', () {
      expect(WeightDecrementButtonPressed().props, []);
    });

    test('AgeIncrementButtonPressed', () {
      expect(AgeIncrementButtonPressed().props, []);
    });

    test('AgeDecrementButtonPressed', () {
      expect(AgeDecrementButtonPressed().props, []);
    });
  });
}
