import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import 'package:get/get.dart';
import '../services/splash_screens/loadingLogin.dart';
import '../widgets/image.dart';
import '../widgets/onboarding_container.dart';
import '../widgets/text.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LiquidSwipe(
          enableLoop: false,
          waveType: WaveType.liquidReveal,
          enableSideReveal: true,
          pages: [
            onboardingContainer(
                'animation1.gif', 'Be Aware of your Mental Health', '1'),
            onboardingContainer('animation2.gif', 'Get some Help', '2'),
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  const SizedBox(
                    height: 100,
                  ),
                  Center(
                    child: image('assets/images/animation3.gif', 300, 300,
                        EdgeInsets.zero),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  textBold('Conquer your Mental Issues', 24, Colors.black),
                  const Expanded(
                    child: SizedBox(),
                  ),
                  MaterialButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    color: Colors.black,
                    onPressed: () {
                      Get.off(() => LoadingScreenToLogIn());
                    },
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      child: textBold('Continue', 12, Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  textBold('3 of 3', 10, Colors.black),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
          ]),
    );
  }
}
