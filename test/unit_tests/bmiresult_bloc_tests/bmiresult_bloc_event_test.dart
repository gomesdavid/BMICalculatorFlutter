import 'package:bmi_calculator/screens/result/bloc/bmiresult_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CalculateBMIButtonPressed', () {
    expect(CalculateBMIButtonPressed(height: 170, weight: 50).props, [170, 50]);
  });
}
