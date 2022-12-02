import 'package:flutter/material.dart';
import 'package:for_you/widgets/text.dart';


import 'image.dart';

Widget homeContainer(
  String path,
  String title,
  Color c1,
  Color c2,
  Color c3,
) {
  return Container(
    height: 180,
    width: 350,
    decoration: BoxDecoration(
      gradient: LinearGradient(colors: [
        c1,
        c2,
        c3,
      ]),
      borderRadius: BorderRadius.circular(20),
      /*image: const DecorationImage(
        image: AssetImage(
          'assets/images/logo.png',
        ),
      ),
      */
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          textBold(title, 24, Colors.white),
          image('assets/images/' + path, 100, 100, EdgeInsets.zero),
        ],
      ),
    ),
  );
}
