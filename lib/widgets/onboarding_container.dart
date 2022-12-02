import 'package:flutter/material.dart';
import 'package:for_you/widgets/text.dart';

import 'image.dart';


Widget onboardingContainer(String imageSource, String title, String num) {
  return Container(
    color: Colors.white,
    child: Column(
      children: [
        const SizedBox(
          height: 100,
        ),
        Center(
          child:
              image('assets/images/' + imageSource, 300, 300, EdgeInsets.zero),
        ),
        const SizedBox(
          height: 50,
        ),
        textBold(title, 18, Colors.black),
        const Expanded(
          child: SizedBox(),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.arrow_back,
              size: 18,
            ),
            const SizedBox(
              width: 10,
            ),
            textBold('Swipe', 12, Colors.black),
          ],
        ),
        const SizedBox(
          height: 50,
        ),
        textBold(num + ' of 3', 10, Colors.black),
        const SizedBox(
          height: 20,
        ),
      ],
    ),
  );
}
