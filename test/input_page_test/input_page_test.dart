import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator/screens/input_page/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/screens/input_page/input_page.dart';
import 'package:bmi_calculator/screens/result/bloc/bmiresult_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test_helper/test_helper.dart';

class MockBmiBloc extends Mock implements BmiBloc {}

class MockBmiResultBloc extends Mock implements BmiResultBloc {}

class FakeRoute<T> extends Fake implements Route<T> {}

class FakeHeightSlider extends Fake implements HeightSliderChanged {}

final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();

Future<void> _bindScreen() async =>
    await binding.setSurfaceSize(Size(640, 640));

void main() {
  Widget testingWidget;
  final bmiBloc = MockBmiBloc();
  var navigatorObserver = MockNavigatorObserver();
  final bmiResultBloc = MockBmiResultBloc();

  setUp(() {
    testingWidget = testWidget(
      BlocProvider<BmiBloc>(
        create: (context) => bmiBloc,
        child: InputPage(
          bmiResultBloc: bmiResultBloc,
        ),
      ),
      navObserver: navigatorObserver,
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeRoute());
    registerFallbackValue(FakeHeightSlider());
  });

  group('buttons', () {
    testWidgets('male gender button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final maleButton = find.byKey(Key('input_page_gender_male_reusableCard'));
      expect(maleButton, findsOneWidget);
      await tester.tap(maleButton);
      await tester.pump();
      verify(() => bmiBloc.add(GenderMaleButtonPressed()));
    });

    testWidgets('female gender button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final femaleButton =
          find.byKey(Key('input_page_gender_female_reusableCard'));
      expect(femaleButton, findsOneWidget);
      await tester.tap(femaleButton);
      await tester.pump();
      verify(() => bmiBloc.add(GenderFemaleButtonPressed()));
    });

    testWidgets('height slider value changed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final heightSlider = find.byKey(Key('input_page_height_slider'));
      expect(heightSlider, findsOneWidget);
      await tester.drag(heightSlider, Offset(20, 0));
      await tester.pump();
      verify(() => bmiBloc.add(any<HeightSliderChanged>()));
    });

    testWidgets('weight decrement button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final weightDecrementButton =
          find.byKey(Key('input_page_weight_button_minus'));
      expect(weightDecrementButton, findsOneWidget);
      await tester.tap(weightDecrementButton);
      await tester.pump();
      verify(() => bmiBloc.add(WeightDecrementButtonPressed()));
    });

    testWidgets('weight increment button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final weightIncrementButton =
          find.byKey(Key('input_page_weight_button_plus'));
      expect(weightIncrementButton, findsOneWidget);
      await tester.tap(weightIncrementButton);
      await tester.pump();
      verify(() => bmiBloc.add(WeightIncrementButtonPressed()));
    });

    testWidgets('age decrement button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final ageDecrementButton = find.byKey(Key('input_page_age_button_minus'));
      expect(ageDecrementButton, findsOneWidget);
      await tester.tap(ageDecrementButton);
      await tester.pump();
      verify(() => bmiBloc.add(AgeDecrementButtonPressed()));
    });

    testWidgets('age increment button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      await _bindScreen();

      await tester.pumpWidget(testingWidget);
      await tester.pumpAndSettle();

      final ageIncrementButton = find.byKey(Key('input_page_age_button_plus'));
      expect(ageIncrementButton, findsOneWidget);
      await tester.tap(ageIncrementButton);
      await tester.pump();
      verify(() => bmiBloc.add(AgeIncrementButtonPressed()));
    });

    testWidgets('calculate button pressed', (tester) async {
      whenListen(
        bmiBloc,
        Stream.fromIterable([BmiInitial()]),
        initialState: BmiInitial(),
      );

      whenListen(
        bmiResultBloc,
        Stream.fromIterable([
          BmiPageLoaded(
              bmiInterpretation:
                  'You have a higher than normal body weight. Try to exercise more.',
              bmiResult: 25,
              bmiResultText: 'Overweight')
        ]),
        initialState: BmiresultInitial(),
      );

      await _bindScreen();

      final navObserver = MockNavigatorObserver();

      await tester.pumpWidget(testWidget(
        BlocProvider<BmiBloc>(
          create: (context) => bmiBloc,
          child: InputPage(
            bmiResultBloc: bmiResultBloc,
          ),
        ),
        navObserver: navObserver,
      ));
      await tester.pumpAndSettle();

      final calculateButton = find.byKey(Key('input_page_calculate_button'));
      expect(calculateButton, findsOneWidget);
      await tester.tap(calculateButton);
      await tester.pumpAndSettle();
      final calculateScaffold = find.byKey(Key('results_page_scaffold'));
      expect(calculateScaffold, findsOneWidget);
      verify(() => navObserver.didPush(captureAny<Route>(), any<Route>()))
          .called(2);
    });
  });

  testWidgets('test default bmi_result bloc input page', (tester) async {
    whenListen(
      bmiBloc,
      Stream.fromIterable([BmiInitial()]),
      initialState: BmiInitial(),
    );
    await _bindScreen();

    await tester.pumpWidget(
      testWidget(
        BlocProvider<BmiBloc>(
          create: (context) => bmiBloc,
          child: InputPage(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    final inputPageScaffold = find.byKey(Key('input_page_scaffold'));
    expect(inputPageScaffold, findsOneWidget);
  });

  testWidgets(
      'ciruclar progress indicator is shown when progress state is emitted',
      (tester) async {
    whenListen(
      bmiBloc,
      Stream.fromIterable([BmiLoadingProcess()]),
      initialState: BmiLoadingProcess(),
    );

    await tester.pumpWidget(testingWidget);
    await tester.pump();
    final circularProgressIndicator =
        find.byKey(Key('input_page_circularProgressIndicator'));
    expect(circularProgressIndicator, findsOneWidget);
  });

  testWidgets('input_page content is shown', (tester) async {
    whenListen(
      bmiBloc,
      Stream.fromIterable([BmiInitial()]),
      initialState: BmiInitial(),
    );

    whenListen(
      bmiResultBloc,
      Stream.fromIterable([BmiresultInitial()]),
      initialState: BmiresultInitial(),
    );

    await _bindScreen();
// Stub the state stream

    await tester.pumpWidget(testingWidget);
    await tester.pumpAndSettle();

    final circularProIndicatorWidget =
        find.byKey(Key('input_page_circularProgressIndicator'));
    expect(circularProIndicatorWidget, findsNothing);

    final inputPageGenderMaleReusableCard =
        find.byKey(Key('input_page_gender_male_reusableCard'));
    expect(inputPageGenderMaleReusableCard, findsOneWidget);

    final inputPageGenderMaleIcon =
        find.byKey(Key('input_page_gender_male_icon'));
    expect(inputPageGenderMaleIcon, findsOneWidget);

    final inputPageGenderFemaleReusableCard =
        find.byKey(Key('input_page_gender_female_reusableCard'));
    expect(inputPageGenderFemaleReusableCard, findsOneWidget);

    final inputPageGenderFemaleIcon =
        find.byKey(Key('input_page_gender_female_icon'));
    expect(inputPageGenderFemaleIcon, findsOneWidget);

    final inputPageHeightReusableCard =
        find.byKey(Key('input_page_height_reusableCard'));
    expect(inputPageHeightReusableCard, findsOneWidget);

    final inputPageHeightText = find.text('HEIGHT');
    expect(inputPageHeightText, findsOneWidget);

    final inputPageHeightValueText = find.text(BmiInitial().height.toString());
    expect(inputPageHeightValueText, findsOneWidget);

    final inputPageHeightCmText = find.text('cm');
    expect(inputPageHeightCmText, findsOneWidget);

    final inputPageHeightSlider = find.byKey(Key('input_page_height_slider'));
    expect(inputPageHeightSlider, findsOneWidget);

    final inputPageWeightReusableCard =
        find.byKey(Key('input_page_weight_reusableCard'));
    expect(inputPageWeightReusableCard, findsOneWidget);

    final inputPageWeightText = find.text('WEIGHT');
    expect(inputPageWeightText, findsOneWidget);

    final inputPageWeightValueText = find.text(BmiInitial().weight.toString());
    expect(inputPageWeightValueText, findsOneWidget);

    final inputPageWeightButtonMinus =
        find.byKey(Key('input_page_weight_button_minus'));
    expect(inputPageWeightButtonMinus, findsOneWidget);

    final inputPageWeightButtonPlus =
        find.byKey(Key('input_page_weight_button_plus'));
    expect(inputPageWeightButtonPlus, findsOneWidget);

    final inputPageAgeReusableCard =
        find.byKey(Key('input_page_age_reusableCard'));
    expect(inputPageAgeReusableCard, findsOneWidget);

    final inputPageAgeText = find.text('AGE');
    expect(inputPageAgeText, findsOneWidget);

    final inputPageAgeValueText = find.text(BmiInitial().age.toString());
    expect(inputPageAgeValueText, findsOneWidget);

    final inputPageAgeButtonMinus =
        find.byKey(Key('input_page_age_button_minus'));
    expect(inputPageAgeButtonMinus, findsOneWidget);

    final inputPageAgeButtonPlus =
        find.byKey(Key('input_page_age_button_plus'));
    expect(inputPageAgeButtonPlus, findsOneWidget);

    final inputPageCalculateButton =
        find.byKey(Key('input_page_calculate_button'));
    expect(inputPageCalculateButton, findsOneWidget);
  });

  testWidgets('input page initial state', (tester) async {
    whenListen(
      bmiBloc,
      Stream.fromIterable([BmiInitial()]),
      initialState: BmiInitial(),
    );

    await _bindScreen();

    await tester.pumpWidget(testingWidget);
    await tester.pumpAndSettle();
    expect(bmiResultBloc.state, BmiresultInitial());
  });
}
