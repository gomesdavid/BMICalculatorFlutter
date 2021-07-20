# <center> BMI Calculator</center>

<br>
<center>

![Build](https://github.com/gomesdavid/BMICalculatorFlutter/actions/workflows/actions-main.yaml/badge.svg) [![codecov](https://codecov.io/gh/gomesdavid/BMICalculatorFlutter/branch/master/graph/badge.svg?token=VQBSRV93FO)](https://codecov.io/gh/gomesdavid/BMICalculatorFlutter)
</center>

---

<p> This <b>BMI Calculator</b> project was created in flutter using the <a href="https://github.com/felangel/bloc">BLoC package</a>, with all widgets, features and bloc <a href="https://app.codecov.io/gh/gomesdavid/BMICalculatorFlutter">tested using codecov</a>. </p>

---

### What It Is

This project contains the basic features of a simple BMI calculator where you can <b>select your gender, select your height (centimeters), select your weight (kilos), select your age</b> and then press a button that will show the <b>value of your BMI calculated, the interpretation of the value taking into account your height, weight, etc, and it also shows a little description of the BMI value</b>.

---

### Examples

<table>
    <tr>
        <td>
            <img src="https://raw.githubusercontent.com/gomesdavid/BMICalculatorFlutter/master/.github/images/bmi_calculator_print_main_page.png" width="250" height="500"/>
        </td>
        <td>
            <img src="https://raw.githubusercontent.com/gomesdavid/BMICalculatorFlutter/master/.github/images/bmi_calculator_print_normal_result_normal.png" width="250" height="500"/>
        </td>
    </tr>
    <tr>
        <td>
            <img src="https://raw.githubusercontent.com/gomesdavid/BMICalculatorFlutter/master/.github/images/bmi_calculator_print_normal_result_overweight.png" width="250" height="500"/>
        </td>
        <td>
            <img src="https://raw.githubusercontent.com/gomesdavid/BMICalculatorFlutter/master/.github/images/bmi_calculator_print_normal_result_underweight.png" width="250" height="500"/>
        </td>
    </tr>
</table>

---

### State Management with BLoC

##### Input Page bloc

```dart     
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
```

##### Results Page bloc

```dart
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
```

---

### How to Use

**Step 1:**
Download or clone this repo by using the link below:

```
https://github.com/gomesdavid/BMICalculatorFlutter.git
```

**Step 2:**

Go to project root and execute the following command in console to get the required dependencies:

```
flutter pub get
```

**Step 3:**

Run the project.

---

