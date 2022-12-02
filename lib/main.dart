import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:for_you/screens/onboarding_screen.dart';
import 'package:for_you/services/splash_screens/loadingHome.dart';
import 'package:get/get.dart';


import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      name: "For You",
      options: const FirebaseOptions(
          apiKey: 'AIzaSyB6jfxxiUvEp84CASzHyLytbXJTCDrAzYg', //a code used to identify and authenticate an application or user
          appId: '1:155538289966:android:0f82edc46d5724135536bf', //unique identifier for the project across all of Firebase and Google Cloud.
          messagingSenderId: '155538289966',
          projectId: 'tdclifecare-776b9'));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(), //aron dili mag balik balik ang user
            builder: (context, snapshot) {                  // ug relog sa application
            if (snapshot.hasData) {
              return LoadingScreenToHome();
            } else {
              return const OnboardingPage();
            }
          }),
    );
  }
}
