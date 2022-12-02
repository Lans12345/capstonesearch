import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import '../../widgets/text.dart';
import '../home.dart';
class Contact extends StatefulWidget {
  const Contact({Key? key}) : super(key: key);

  @override
  State<Contact> createState() => _ContactState();
}
//navigator siya sa flutter which routes you to different screens
class _ContactState extends State<Contact> {
  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => //ang alert dialogue kay mo pop up once pisliton ang icon nga back
          AlertDialog(
            title: const Text('Are you sure?'),
            content: const Text('Do you want to leave?'),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('No'),
              ),
              FlatButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => HomePage()));
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
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
        body: Column(
          children: <Widget>[
            Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Image.asset('assets/images/up.png'),
                Text(
                  'Contact Us',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),
                ),
              ],
            ),
            IntrinsicHeight(
              child: Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: themeData.dividerColor,
                    ),
                  ),
                ),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('(+639)-661-994-775'),
                                    Text(
                                      'Mobile',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Icon(
                                  Icons.call,
                                  color: themeData.primaryColor,
                                ),
                                height: 60,
                                width: 60,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('TDC LifeCare - Psychological Center'),
                                    Text(
                                      'Facebook',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Icon(
                                  Icons.facebook,
                                  color: themeData.primaryColor,
                                ),
                                height: 60,
                                width: 60,
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text('0922 477 2258'),
                                    Text(
                                      'SMS',
                                      style: TextStyle(
                                        fontSize: 11,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                child: Icon(
                                  Icons.message,
                                  color: themeData.primaryColor,
                                ),
                                height: 60,
                                width: 60,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            IntrinsicHeight(
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          child: Icon(
                            Icons.contact_mail,
                            color: themeData.primaryColor,
                          ),
                          height: 60,
                        )
                      ],
                      mainAxisAlignment: MainAxisAlignment.start,
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Expanded(child: Text('tdclifecare@gmail.com')),
                            SizedBox(
                              child: Icon(
                                Icons.email,
                                color: themeData.primaryColor,
                              ),
                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Expanded(child: Text('')),
                            SizedBox(

                              height: 60,
                              width: 60,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            const Expanded(child: SizedBox(height: 50)),
            MaterialButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),          //This part is if pisliton ang button nga conact TDC,
              color: Colors.cyan[900]!,
              onPressed: () async {       //Once initiated, an asynchronous operation allows other operations to execute before it completes.
                String driverContactNumber = '09090104355';
                final _text = 'tel:$driverContactNumber';
                if (await canLaunch(_text)) {
                  await launch(_text);
                }
              },
              child: Padding(
                padding: const EdgeInsets.fromLTRB(40, 10, 40, 10),
                child: textReg(
                  'Contact Now',
                  12,
                  Colors.white,
                ),
              ),
            ),
        const SizedBox(height: 50),
        const Expanded(child: SizedBox(height: 10)),
        MaterialButton(
        shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
    ),
    color: Colors.black,
          onPressed: () {
            Get.to(() => HomePage(), transition: Transition.zoom);
          },
    child: Padding(
    padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
    child: textReg(
    'Back to Home',
    12,
    Colors.white,
    ),
    ),
        ),
          ],
        ));

  }
}

