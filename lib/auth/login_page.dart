import 'package:flutter/material.dart';
import 'package:for_you/auth/signup_page.dart';

import 'package:get/get.dart';
import '../screens/admin/admin_home.dart';
import '../screens/home.dart';
import '../services/authentication/anonymous.dart';
import '../services/authentication/googleLogin.dart';
import '../services/error.dart';
import '../widgets/image.dart';
import 'package:get_storage/get_storage.dart';

import '../widgets/text.dart';

class LoginPage extends StatelessWidget {
  late String username = '';
  late String password = '';

  GetStorage box = GetStorage(); //local database, matic na, para pud ni sa anonymous sign in

  late String adminPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(
                height: 20,
              ),
              image('assets/images/logo.png', 250, 250, EdgeInsets.zero),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: TextFormField(
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Quicksand'),
                  onChanged: (_input) {
                    username = _input;
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    labelText: 'Username',
                    labelStyle: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                child: TextFormField(
                  obscureText: true,
                  style: const TextStyle(
                      color: Colors.black, fontFamily: 'Quicksand'),
                  onChanged: (_input) {
                    password = _input;
                  },
                  decoration: InputDecoration(
                    suffixIcon: const Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.white),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 1, color: Colors.black),
                      borderRadius: BorderRadius.circular(3),
                    ),
                    labelText: 'Password',
                    labelStyle: const TextStyle(
                      fontFamily: 'Quicksand',
                      color: Colors.black,
                      fontSize: 12.0,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    if (box.read('username') == username &&
                        box.read('password') == password) {
                      signIn();
                      Get.off(() => HomePage(), transition: Transition.zoom);
                    } else {
                      error('Invalid Account');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 80, right: 80),
                    child: textReg('Login', 18.0, Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              textReg('or', 18.0, Colors.black),
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    logInWithGoogle();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        image(
                          'assets/images/googlelogo.png',
                          25,
                          25,
                          EdgeInsets.zero,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        textReg('Login with Google', 18.0, Colors.black),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 60, right: 60, top: 10),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  color: Colors.white,
                  onPressed: () {
                    showDialog(
                      context: context,
                      barrierDismissible: false,
                      builder: (BuildContext context) => Padding(
                        padding: const EdgeInsets.only(left: 30, right: 30),
                        child: AlertDialog(
                          title: const Text(
                            'Administrator Password',
                            style: TextStyle(
                                fontSize: 12,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'QRegular'),
                          ),
                          content: TextFormField(
                              obscureText: true,
                              onChanged: (_input) {
                                adminPassword = _input;
                              },
                              decoration: const InputDecoration(
                                  prefixIcon: Icon(Icons.lock))),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  if (adminPassword == 'admin123') {
                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminHome()));
                                  } else {
                                    showDialog(
                                      context: context,
                                      barrierDismissible: false,
                                      builder: (BuildContext context) =>
                                          Padding(
                                        padding: const EdgeInsets.only(
                                            left: 30, right: 30),
                                        child: AlertDialog(
                                          title: const Text(
                                            'Invalid Password',
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'QRegular'),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  Navigator.of(context).pop();
                                                },
                                                child: textReg(
                                                    'Close', 13, Colors.black)),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                },
                                child: textBold('Continue', 13, Colors.black)),
                          ],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 10, bottom: 10, left: 15, right: 15),
                    child:
                        textReg('Login as Admininistrator', 18.0, Colors.black),
                  ),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textReg('No Account?', 14.0, Colors.black),
                  TextButton(
                    onPressed: () {
                      Get.to(() => const SignUpPage(),
                          transition: Transition.zoom);
                    },
                    child: textBold('Create now', 15.0, Colors.blue),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
