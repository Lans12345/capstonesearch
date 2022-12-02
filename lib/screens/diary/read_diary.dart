import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';

import '../../widgets/text.dart';

class ReadDiary extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: textBold(box.read('diary_title'), 24, Colors.white),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.blue[400]!,
              Colors.pink[300]!,
              Colors.purple[400]!,
            ]),
          ),
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textReg(box.read('diary_date'), 18, Colors.black),
              ],
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          SizedBox(
            width: 280,
            child: textReg(box.read('diary_content'), 14, Colors.black),
          ),
        ],
      ),
    );
  }
}
