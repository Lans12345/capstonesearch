import 'package:flutter/material.dart';
import 'package:for_you/widgets/text.dart';


class button extends StatelessWidget {
  void Function() onPressed;

  Color color;
  var label = '';

  button({required this.onPressed, required this.color, required this.label});
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: color,
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
        child: textReg(
          label,
          24,
          Colors.white,
        ),
      ),
    );
  }
}
