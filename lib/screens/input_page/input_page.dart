import 'package:bmi_calculator/components/bottom_button.dart';
import 'package:bmi_calculator/components/icon_content.dart';
import 'package:bmi_calculator/components/reusable_card.dart';
import 'package:bmi_calculator/components/round_icon_button.dart';
import 'package:bmi_calculator/screens/result/bloc/bmiresult_bloc.dart';
import 'package:bmi_calculator/screens/result/results_page.dart';
import 'package:bmi_calculator/screens/input_page/models/gender.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../constants.dart';
import 'bloc/bmi_bloc.dart';

class InputPage extends StatefulWidget {
  InputPage({BmiResultBloc bmiResultBloc})
      : _bmiResultBloc = bmiResultBloc ?? BmiResultBloc();

  final BmiResultBloc _bmiResultBloc;

  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('input_page_scaffold'),
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
      ),
      body: BlocBuilder<BmiBloc, BmiState>(
        builder: (context, state) {
          return state is BmiLoadingProcess
              ? Center(
                  child: CircularProgressIndicator(
                    key: Key('input_page_circularProgressIndicator'),
                  ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableCard(
                              key: Key('input_page_gender_male_reusableCard'),
                              onPress: () => context
                                  .read<BmiBloc>()
                                  .add(GenderMaleButtonPressed()),
                              colour: state.gender == Gender.male
                                  ? kActiveCardColour
                                  : kInactiveCardColour,
                              cardChild: IconContent(
                                key: Key('input_page_gender_male_icon'),
                                icon: FontAwesomeIcons.mars,
                                label: 'MALE',
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableCard(
                              key: Key('input_page_gender_female_reusableCard'),
                              onPress: () => context
                                  .read<BmiBloc>()
                                  .add(GenderFemaleButtonPressed()),
                              colour: state.gender == Gender.female
                                  ? kActiveCardColour
                                  : kInactiveCardColour,
                              cardChild: IconContent(
                                key: Key('input_page_gender_female_icon'),
                                icon: FontAwesomeIcons.mars,
                                label: 'FEMALE',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ReusableCard(
                        key: Key('input_page_height_reusableCard'),
                        colour: kActiveCardColour,
                        cardChild: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'HEIGHT',
                              style: kLabelTextStyle,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.baseline,
                              textBaseline: TextBaseline.alphabetic,
                              children: [
                                Text(
                                  state.height.toString(),
                                  style: kNumberTextStyle,
                                ),
                                Text(
                                  'cm',
                                  style: kLabelTextStyle,
                                ),
                              ],
                            ),
                            SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                activeTrackColor: Colors.white,
                                inactiveTrackColor: Color(0xFF8D8E98),
                                thumbColor: Color(0xFFEB1555),
                                overlayColor: Color(0x29EB1555),
                                thumbShape: RoundSliderThumbShape(
                                    enabledThumbRadius: 15.0),
                                overlayShape: RoundSliderOverlayShape(
                                    overlayRadius: 30.0),
                              ),
                              child: Slider(
                                key: Key('input_page_height_slider'),
                                value: state.height.toDouble(),
                                min: 120.0,
                                max: 220.0,
                                onChanged: (double newValue) => context
                                    .read<BmiBloc>()
                                    .add(HeightSliderChanged(newValue.round())),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            child: ReusableCard(
                              key: Key('input_page_weight_reusableCard'),
                              colour: kActiveCardColour,
                              cardChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'WEIGHT',
                                    style: kLabelTextStyle,
                                  ),
                                  Text(
                                    state.weight.toString(),
                                    style: kNumberTextStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RoundIconButton(
                                        key: Key(
                                            'input_page_weight_button_minus'),
                                        icon: FontAwesomeIcons.minus,
                                        onPressed: () => context
                                            .read<BmiBloc>()
                                            .add(
                                                WeightDecrementButtonPressed()),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      RoundIconButton(
                                        key: Key(
                                            'input_page_weight_button_plus'),
                                        icon: FontAwesomeIcons.plus,
                                        onPressed: () =>
                                            context.read<BmiBloc>().add(
                                                  WeightIncrementButtonPressed(),
                                                ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: ReusableCard(
                              key: Key('input_page_age_reusableCard'),
                              colour: kActiveCardColour,
                              cardChild: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    'AGE',
                                    style: kLabelTextStyle,
                                  ),
                                  Text(
                                    state.age.toString(),
                                    style: kNumberTextStyle,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      RoundIconButton(
                                        key: Key('input_page_age_button_minus'),
                                        icon: FontAwesomeIcons.minus,
                                        onPressed: () => context
                                            .read<BmiBloc>()
                                            .add(AgeDecrementButtonPressed()),
                                      ),
                                      SizedBox(
                                        width: 10.0,
                                      ),
                                      RoundIconButton(
                                        key: Key('input_page_age_button_plus'),
                                        icon: FontAwesomeIcons.plus,
                                        onPressed: () => context
                                            .read<BmiBloc>()
                                            .add(AgeIncrementButtonPressed()),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    BottomButton(
                      key: Key('input_page_calculate_button'),
                      buttonTitle: 'CALCULATE',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => widget._bmiResultBloc
                                ..add(
                                  CalculateBMIButtonPressed(
                                    height: state.height,
                                    weight: state.weight,
                                  ),
                                ),
                              child: ResultsPage(),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
        },
      ),
    );
  }
}
