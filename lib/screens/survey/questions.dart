import 'package:flutter/material.dart';

import '../../widgets/text.dart';

Widget questions(String number, String question) {
  return Column(
    children: [
      const SizedBox(
        height: 5,
      ),
      textBold('$number of 10', 12, Colors.black),
      const SizedBox(
        height: 10,
      ),
      textReg(question, 12, Colors.black),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
