import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../../widgets/appbar.dart';
import '../../widgets/text.dart';


class ProfilePage extends StatelessWidget {
  GetStorage box = GetStorage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar("Users Profile"),
      body: Center(
        child: Column(
          children: [
            const SizedBox(
              height: 50,
            ),
            CircleAvatar(
              minRadius: 70,
              maxRadius: 70,
              backgroundImage: NetworkImage(
                box.read('profilePicture'),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            textBold(
              box.read('name') ?? 'Not Available',
              18,
              Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            textReg(
              'Full Name',
              12,
              Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            textBold(
              box.read('gender') ?? 'Not Available',
              18,
              Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            textReg(
              'Gender',
              12,
              Colors.black,
            ),
            const SizedBox(
              height: 20,
            ),
            textBold(
              box.read('address') ?? 'Not Available',
              18,
              Colors.black,
            ),
            const SizedBox(
              height: 5,
            ),
            textReg('Address', 12, Colors.black),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
