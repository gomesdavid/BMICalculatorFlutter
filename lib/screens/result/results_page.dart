import 'package:bmi_calculator/constants.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:flutter/material.dart';
import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/bmiresult_bloc.dart';

class ResultsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('results_page_scaffold'),
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: BlocBuilder<BmiResultBloc, BmiresultState>(
        builder: (context, state) => state is BmiPageLoaded
            ? Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Container(
                      // key: Key('results_page_'),
                      padding: EdgeInsets.all(15.0),
                      alignment: Alignment.bottomLeft,
                      child: Text(
                        'Your Result',
                        style: kTitleTextStyle,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: ReusableCard(
                      key: Key('results_page_results_reusableCard'),
                      colour: kActiveCardColour,
                      cardChild: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            state.bmiResultText.toUpperCase(),
                            style: kResultTextStyle,
                          ),
                          Text(
                            state.bmiResult.toStringAsFixed(1),
                            style: kBMITextStyle,
                          ),
                          Text(
                            state.bmiInterpretation,
                            style: kBodyTextStyle,
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  BottomButton(
                      key: Key('results_page_recalculate_bmi'),
                      onTap: () {
                        Navigator.pop(context);
                      },
                      buttonTitle: 'RE-CALCULATE')
                ],
              )
            : Container(
                key: Key('results_page_loading_container'),
              ),
      ),
    );
  }
}
