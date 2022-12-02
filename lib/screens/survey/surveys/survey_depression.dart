import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/cloud_function/depression_data.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text.dart';
import '../questions.dart';
import '../survey.dart';

class SurveyDepression extends StatefulWidget {
  const SurveyDepression({Key? key}) : super(key: key);

  @override
  State<SurveyDepression> createState() => _SurveyDepressionState();
}

class _SurveyDepressionState extends State<SurveyDepression> {
  var _index = 0;

  var _isVisible = true;
  var _isVisible2 = false;

  var count = 0;

  final box = GetStorage();

  res() {
    if (count > 20 || count == 20) {
      return 'Severe depression';
    } else if (count > 15 || count == 15 && count < 19) {
      return 'Moderately sever depression';
    } else if (count > 10 || count == 10 && count < 14) {
      return 'Moderate depression';
    } else if (count > 5 || count == 5 && count < 9) {
      return 'Mild depression';
    } else if (count < 4 || count == 4) {
      return 'Minimal depression';
    } else {
      return 'Minimal depression';
    }
  }

  res1() {
    if (count >= 15) {
      return 80.00;
    } else if (count > 5 || count == 5 && count < 9) {
      return 50.00;
    } else if (count < 4 || count == 4) {
      return 5.00;
    } else if (count > 10 || count == 10 && count < 14) {
      return 65.00;
    } else if (count == 0) {
      return 0.00;
    }
  }

  dialogMeter() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              title: Text(
                'Result: ' + res(),
                style: const TextStyle(
                    fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
              ),
              content: SizedBox(
                height: 250,
                child: SfRadialGauge(
                  axes: <RadialAxis>[
                    RadialAxis(
                        showLabels: false,
                        showAxisLine: false,
                        showTicks: false,
                        minimum: 0,
                        maximum: 99,
                        ranges: <GaugeRange>[
                          GaugeRange(
                              startValue: 0,
                              endValue: 33,
                              color: const Color(0xFF5BA85B),
                              label: 'Mild',
                              sizeUnit: GaugeSizeUnit.factor,
                              labelStyle: const GaugeTextStyle(
                                  fontFamily: 'Times', fontSize: 20),
                              startWidth: 0.65,
                              endWidth: 0.65),
                          GaugeRange(
                            startValue: 33,
                            endValue: 66,
                            color: const Color(0xFFFFD54F),
                            label: 'Moderate',
                            labelStyle: const GaugeTextStyle(
                                fontFamily: 'Times', fontSize: 20),
                            startWidth: 0.65,
                            endWidth: 0.65,
                            sizeUnit: GaugeSizeUnit.factor,
                          ),
                          GaugeRange(
                            startValue: 66,
                            endValue: 99,
                            color: const Color(0xFFE57373),
                            label: 'Severe',
                            labelStyle: const GaugeTextStyle(
                                fontFamily: 'Times', fontSize: 20),
                            sizeUnit: GaugeSizeUnit.factor,
                            startWidth: 0.65,
                            endWidth: 0.65,
                          ),
                        ],
                        pointers: <GaugePointer>[
                          NeedlePointer(value: res1())
                        ])
                  ],
                ),
              ),
              actions: <Widget>[
                FlatButton(
                  onPressed: () {
                    addDepression(box.read('name'), box.read('contactNumber'),
                        res(), box.read('profilePicture'));
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Survey()));
                  },
                  child: const Text(
                    'Continue',
                    style: TextStyle(
                        fontFamily: 'Quicksand', fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar('Survey for Depression'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 120,
                width: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(color: Colors.grey, width: 2),
                ),
                child: Center(
                    child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: IndexedStack(
                    index: _index,
                    children: [
                      Center(
                          child: questions('1',
                              'Little interest or pleasure in doing things')),
                      Center(
                          child: questions(
                              '2', 'Feeling down, depressed, or hopeless')),
                      Center(
                          child: questions('3',
                              'Trouble falling or staying asleep, or sleeping to much')),
                      Center(
                          child: questions(
                              '4', 'Feeling tired or having little energy')),
                      Center(
                          child: questions('5', 'Poor appetite or overeating')),
                      Center(
                          child: questions('6',
                              'Feeling bad about yourself or that you are a failure or have let youself or your family down')),
                      Center(
                          child: questions('7',
                              'Trouble concentrating on things, such as reading the newspaper or watching tevelision')),
                      Center(
                          child: questions('8',
                              'Moving or speaking so slowly that other people could have noticed.')),
                      Center(
                          child: questions('9',
                              'Thoughts that you would be better off dead, or of hurting yourself')),
                      Center(
                          child: questions('10',
                              'If you checked off any problems, how difficult have these problems made it for you to do your work, take care of things at home, or get along with other people?')),
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            textBold('Result', 12, Colors.black),
                            const SizedBox(
                              height: 14,
                            ),
                            textBold(res(), 18, Colors.black),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _isVisible,
                child: MaterialButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_index != 9) {
                        _index++;
                        count = count + 3;
                        print(count);
                      } else if (_index == 9) {
                        _isVisible = false;
                        _isVisible2 = true;
                        dialogMeter();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: textBold('Nearly every day', 18, Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _isVisible,
                child: MaterialButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_index != 9) {
                        _index++;
                        count = count + 2;
                        print(count);
                      } else if (_index == 9) {
                        _isVisible = false;
                        _isVisible2 = true;
                        dialogMeter();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(38, 20, 38, 20),
                    child:
                        textBold('More than half the days', 14, Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _isVisible,
                child: MaterialButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_index != 9) {
                        _index++;

                        count = count + 1;
                        print(count);
                      } else if (_index == 9) {
                        _isVisible = false;
                        _isVisible2 = true;
                        dialogMeter();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(55, 20, 55, 20),
                    child: textBold('Several days', 18, Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Visibility(
                visible: _isVisible,
                child: MaterialButton(
                  color: Colors.amber,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100),
                  ),
                  onPressed: () {
                    setState(() {
                      if (_index != 9) {
                        _index++;
                        count = count + 0;
                        print(count);
                      } else if (_index == 9) {
                        _isVisible = false;
                        _isVisible2 = true;
                        dialogMeter();
                      }
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(68, 20, 68, 20),
                    child: textBold('Not at all', 18, Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
