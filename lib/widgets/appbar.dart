import 'package:flutter/material.dart';
import 'package:for_you/widgets/text.dart';


PreferredSizeWidget appbar(String title) {
  return AppBar(
    title: textBold(title, 24, Colors.white),
    centerTitle: true,
    flexibleSpace: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [
          Colors.blue!,
          Colors.blue[600]!,
          Colors.teal[200]!,
        ]),
      ),
    ),
  );
}
