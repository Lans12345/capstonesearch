import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../../auth/login_page.dart';
import '../../widgets/dialog.dart';
import '../../widgets/image.dart';
import '../../widgets/text.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(          //Tab bar para ma divide into two section ang diary ug MHA result
      length: 2,                          //DefaultTabController is an inherited widget that is used to share a
      child: Scaffold(                    //TabController with a TabBar or a TabBarView.
        backgroundColor: Colors.grey[100],
        appBar: AppBar(                   //
          bottom: TabBar(tabs: [
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  image('assets/images/diary.png', 30, 30, EdgeInsets.zero),
                  const SizedBox(
                    height: 5,
                  ),
                  textReg('Diary', 10, Colors.white),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Column(
                children: [
                  image('assets/images/qa.png', 30, 30, EdgeInsets.zero),
                  const SizedBox(
                    height: 5,
                  ),
                  textReg('MHA', 10, Colors.white),
                ],
              ),
            ),
          ]),
          actions: [
            IconButton(
              onPressed: () {
                dialogWithClose('Logout Confirmation',
                    'Are you sure you want to logout?', LoginPage());
              },
              icon: const Icon(Icons.logout),
            ),
          ],
          automaticallyImplyLeading: false,
          title: textBold('Admin Home', 24, Colors.white),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.lightBlue[300]!,
                Colors.lightBlue[400]!,
                Colors.lightBlue!,
              ]),
            ),
          ),
        ),
        body: TabBarView(children: [
          StreamBuilder<QuerySnapshot>(
              stream:
                  FirebaseFirestore.instance.collection('Diary').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return SizedBox(
                  child: ListView.builder(
                    itemCount: snapshot.data?.size ?? 0,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ColoredBox(
                          color: Colors.white,
                          child: ExpansionTile(
                            trailing: textReg(
                                data.docs[index]['date'], 14, Colors.black),
                            leading: CircleAvatar(
                              maxRadius: 30,
                              minRadius: 30,
                              backgroundImage: NetworkImage(
                                  data.docs[index]['profilePicture']),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textReg('Tap to read diary', 10, Colors.grey),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  textBold(data.docs[index]['title'], 18,
                                      Colors.black),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textReg('By: ' + data.docs[index]['name'], 12,
                                    Colors.grey),
                                textReg(
                                    'Contact #: ' +
                                        data.docs[index]['contactNumber'],
                                    10,
                                    Colors.grey),
                              ],
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: textReg(data.docs[index]['content'], 12,
                                    Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance.collection('Data').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  print('error');
                  return const Center(child: Text('Error'));
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  print('waiting');
                  return const Padding(
                    padding: EdgeInsets.only(top: 50),
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.blue,
                    )),
                  );
                }

                final data = snapshot.requireData;
                return SizedBox(
                  child: ListView.builder(
                    itemCount: snapshot.data?.size ?? 0,
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ColoredBox(
                          color: Colors.white,
                          child: ExpansionTile(
                            trailing: textReg('', 10, Colors.grey),
                            leading: CircleAvatar(
                              maxRadius: 30,
                              minRadius: 30,
                              backgroundImage: NetworkImage(
                                  data.docs[index]['profilePicture']),
                            ),
                            title: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  textReg(data.docs[index]['type'] + ' Test',
                                      10, Colors.green),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  textBold(
                                      'Result: ' + data.docs[index]['result'],
                                      16,
                                      Colors.black),
                                ],
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                textReg(
                                    data.docs[index]['name'], 12, Colors.grey),
                                textReg(data.docs[index]['contactNumber'], 10,
                                    Colors.grey),
                              ],
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                );
              }),
        ]),
      ),
    );
  }
}
