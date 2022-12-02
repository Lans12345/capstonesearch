import 'package:flutter/material.dart';
import 'package:for_you/screens/survey/surveys/survey_anxiety.dart';
import 'package:for_you/screens/survey/surveys/survey_depression.dart';
import 'package:for_you/screens/survey/surveys/survey_stress.dart';

import 'package:get/get.dart';

import '../../widgets/appbar.dart';
import '../../widgets/button.dart';
import '../../widgets/text.dart';
import '../home.dart';

class Survey extends StatefulWidget {
  const Survey({Key? key}) : super(key: key);

  @override
  State<Survey> createState() => _SurveyState();
}

class _SurveyState extends State<Survey> {
  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to leave?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          FlatButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => HomePage()));
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbar('Screening'),
        body: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                    child: textBold('Test For:', 24, Colors.black),
                  )),
              const SizedBox(
                height: 50,
              ),
              button(
                onPressed: () {
                  Get.off(() => const SurveyStress(),
                      transition: Transition.zoom);
                },
                color: Colors.amber[300]!,
                label: 'STRESS',
              ),
              const SizedBox(
                height: 30,
              ),
              button(
                onPressed: () {
                  Get.to(() => const SurveyAnxiety(),
                      transition: Transition.zoom);
                },
                color: Colors.amber[400]!,
                label: 'ANXIETY',
              ),
              const SizedBox(
                height: 30,
              ),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.amber,
                onPressed: () {
                  Get.to(() => const SurveyDepression(),
                      transition: Transition.zoom);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                  child: textReg(
                    'DEPRESSION',
                    18,
                    Colors.white,
                  ),
                ),
              ),
              const Expanded(child: SizedBox(height: 50)),
              MaterialButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.black,
                onPressed: () {
                  Get.to(() => HomePage(), transition: Transition.zoom);
                },
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: textReg(
                    'Back to Home',
                    12,
                    Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
