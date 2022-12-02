import 'package:flutter/material.dart';

import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:get_storage/get_storage.dart';

import '../../../services/cloud_function/stress_data.dart';
import '../../../widgets/appbar.dart';
import '../../../widgets/text.dart';
import '../questions.dart';
import '../survey.dart';

class SurveyStress extends StatefulWidget {
  const SurveyStress({Key? key}) : super(key: key);

  @override
  State<SurveyStress> createState() => _SurveyStressState();
}

class _SurveyStressState extends State<SurveyStress> {
  var _index = 0;

  var _isVisible = true;
  var _isVisible2 = false;

  var count = 0;

  final box = GetStorage();

  res() {
    if (count > 27 || count == 27) {
      return 'High Perceived Stress';
    } else if (count > 14 || count == 14 && count < 26) {
      return 'Moderate Stress';
    } else if (count < 13 || count == 13) {
      return 'Low Stress';
    }
  }

  res1() {
    if (count > 27 || count == 27) {
      return 99.00;
    } else if (count > 14 || count == 14 && count < 26) {
      return 50.00;
    } else if (count < 13 || count == 13) {
      return 20.00;
    } else if (count == 0) {
      return 00.00;
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
                              label: 'Low',
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
                            label: 'High',
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
                    addStress(box.read('name'), box.read('contactNumber'),
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
      appBar: appbar('Survey for Stress'),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 100,
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
                              'In the last month, how often have you been upset because of something that happened unexpectedly?')),
                      Center(
                          child: questions('2',
                              'In the last month, how often have you felt that you were unable to control the important things in your life?')),
                      Center(
                          child: questions('3',
                              'In the last month, how often have you felt nervous and stressed?')),
                      Center(
                          child: questions('4',
                              'In the last month, how often have you felt confident about your ability to handle your personal problems?')),
                      Center(
                          child: questions('5',
                              'In the last month, how often have you felt that things were going your way?')),
                      Center(
                          child: questions('6',
                              'In the last month, how often have you found that you could not cope with all the things that you had to do?')),
                      Center(
                          child: questions('7',
                              'In the last month, how often have you been able to control irritations in your life?')),
                      Center(
                          child: questions('8',
                              'In the last month, how often have you felt that you were on top of things?')),
                      Center(
                          child: questions('9',
                              'In the last month, how often have you been angered because of things that happened that were outside of your control?')),
                      Center(
                          child: questions('10',
                              'In the last month, how often have you felt difficulties were piling up so high that you could not overcome them?')),
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
                        count = count + 4;
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
                    child: textBold('Very Often', 18, Colors.white),
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
                    child: textBold('Fairly Often', 18, Colors.white),
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
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    child: textBold('Sometimes', 18, Colors.white),
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
                    padding: const EdgeInsets.fromLTRB(35, 20, 35, 20),
                    child: textBold('Almost Never', 18, Colors.white),
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
                    padding: const EdgeInsets.fromLTRB(65, 20, 65, 20),
                    child: textBold('Never', 18, Colors.white),
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
