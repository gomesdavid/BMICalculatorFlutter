import 'package:bloc_test/bloc_test.dart';
import 'package:bmi_calculator/screens/input_page/bloc/bmi_bloc.dart';
import 'package:bmi_calculator/screens/result/results_page.dart';
import 'package:bmi_calculator/screens/result/bloc/bmiresult_bloc.dart';
import 'package:flutter/material.dart';
import '../test_helper/test_helper.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

class MockBmiBloc extends Mock implements BmiBloc {}

class MockBmiResultBloc extends Mock implements BmiResultBloc {}

class FakeRoute<T> extends Fake implements Route<T> {}

final TestWidgetsFlutterBinding binding =
    TestWidgetsFlutterBinding.ensureInitialized();

Future<void> _bindScreen() async =>
    await binding.setSurfaceSize(Size(640, 640));

void main() {
  Widget testingWidget;
  final bmiBloc = MockBmiBloc();
  // final navigatorObserver = MockNavigatorObserver();
  final bmiResultBloc = MockBmiResultBloc();

  setUp(() {
    testingWidget = testWidget(
      BlocProvider<BmiResultBloc>(
        create: (context) => bmiResultBloc,
        child: ResultsPage(),
      ),
    );
  });

  setUpAll(() {
    registerFallbackValue(FakeRoute());
  });

  testWidgets('recalculate button pressed', (tester) async {
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
      BlocProvider<BmiResultBloc>(
        create: (context) => bmiResultBloc,
        child: ResultsPage(),
      ),
      navObserver: navObserver,
    ));
    await tester.pumpAndSettle();

    final recalculateButton = find.byKey(Key('results_page_recalculate_bmi'));
    expect(recalculateButton, findsOneWidget);
    await tester.tap(recalculateButton);
    await tester.pumpAndSettle();
    final resultsPageScaffold = find.byKey(Key('results_page_scaffold'));
    expect(resultsPageScaffold, findsNothing);
    verify(() => navObserver.didPop(captureAny<Route>(), any<Route>()))
        .called(1);

    // final inputPageScaffold = find.byKey(Key('input_page_scaffold'));
    // expect(inputPageScaffold, findsOneWidget);
  });
  testWidgets('results_page content is shown', (tester) async {
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
    await tester.pumpWidget(testingWidget);
    await tester.pumpAndSettle();

    final resultsPageLoadingContainer =
        find.byKey(Key('results_page_loading_container'));
    expect(resultsPageLoadingContainer, findsNothing);

    final resultsPageTitle = find.text('Your Result');
    expect(resultsPageTitle, findsOneWidget);

    final resultsPageResultsReusableCard =
        find.byKey(Key('results_page_results_reusableCard'));
    expect(resultsPageResultsReusableCard, findsOneWidget);

    final resultsPageResultText = find.text('Overweight'.toUpperCase());
    expect(resultsPageResultText, findsOneWidget);

    final resultsPageBMIResult = find.text(25.toStringAsFixed(1));
    expect(resultsPageBMIResult, findsOneWidget);

    final resultsPageBMIInterpretation = find.text(
        'You have a higher than normal body weight. Try to exercise more.');
    expect(resultsPageBMIInterpretation, findsOneWidget);
  });

  testWidgets('results page container is shown when progress state is emitted',
      (tester) async {
    whenListen(
      bmiResultBloc,
      Stream.fromIterable([BmiresultInitial()]),
      initialState: BmiresultInitial(),
    );

    await tester.pumpWidget(testingWidget);
    await tester.pump();
    final circularProgressIndicator =
        find.byKey(Key('results_page_loading_container'));
    expect(circularProgressIndicator, findsOneWidget);
  });
}
