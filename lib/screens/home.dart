import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:for_you/screens/Contact/contact.dart';
import 'package:for_you/screens/profile/profile_page.dart';
import 'package:for_you/screens/quote/view_quotes.dart';
import 'package:for_you/screens/survey/survey.dart';

import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../auth/login_page.dart';
import '../services/error.dart';
import '../widgets/appbar.dart';
import '../widgets/dialog.dart';
import '../widgets/home_container.dart';
import '../widgets/image.dart';
import '../widgets/text.dart';
import 'diary/write_diary.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GetStorage box = GetStorage();

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Are you sure?'),
        content: const Text('Do you want to leave?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('No'),
          ),
          FlatButton(
            onPressed: () {
              SystemNavigator.pop();
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        drawer: SizedBox(
          width: 220,
          child: Drawer(
            child: ListView(
              padding: const EdgeInsets.only(top: 0),
              children: <Widget>[
                UserAccountsDrawerHeader(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Colors.amber[200]!,
                      Colors.purple[300]!,
                      Colors.blue[400]!,
                    ]),
                  ),
                  accountEmail: textBold(
                      box.read('contactNumber') ?? '', 12, Colors.white),
                  accountName:
                      textBold(box.read('name') ?? '', 18, Colors.white),
                  currentAccountPicture: CircleAvatar(
                    minRadius: 50,
                    maxRadius: 50,
                    backgroundImage: NetworkImage(box.read('profilePicture') ??
                        'https://cdn-icons-png.flaticon.com/512/149/149071.png'),
                  ),
                ),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: textBold('Profile', 14, Colors.black),
                  onTap: () {
                    Get.to(() => ProfilePage(), transition: Transition.zoom);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.info),
                  title: textBold('About', 14, Colors.black),
                  onTap: () {
                    showAboutDialog(
                        context: context,
                        applicationName: 'Mental Health Guide',
                        applicationIcon: image(
                            'assets/images/logo.png', 50, 50, EdgeInsets.zero),
                        applicationLegalese:
                            'This system is for Capstone Project',
                        applicationVersion: 'v1.0');
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: textBold('Logout', 14, Colors.black),
                  onTap: () {
                    dialogWithClose('Logout Confirmation',
                        'Are you sure you want to logout?', LoginPage());
                    FirebaseAuth.instance.signOut();
                  },
                ),
              ],
            ),
          ),
        ),
        appBar: appbar('Home'),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                GestureDetector(
                  onTap: () async {
                    bool hasInternet =
                        await InternetConnectionChecker().hasConnection;
                    if (hasInternet == true) {
                      Get.to(() => WriteDiary(), transition: Transition.zoom);
                    } else {
                      error('No Internet Connection');
                    }
                  },
                  child: homeContainer('woman.png', 'Self Diary',
                      Colors.lightBlue!, Colors.lightBlue!, Colors.lightBlue[600]!),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => ViewQuote(), transition: Transition.zoom);
                  },
                  child: homeContainer('motiviate.png', "Quote's Motivator",
                      Colors.purpleAccent[700]!, Colors.purpleAccent[700]!, Colors.purpleAccent[400]!),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Survey()));
                  },
                  child: homeContainer('people.png', 'MHA Based QA',
                      Colors.amber[800]!, Colors.amber[800]!, Colors.amber[700]!),
                ),
                const SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => const Contact()));
                  },
                  child: homeContainer(
                      'voice.png',
                      'TDC Support',
                      Colors.indigo[900]!,
                      Colors.indigo[900]!,
                      Colors.indigo[800]!),
                ),
                const SizedBox(
                  height: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
