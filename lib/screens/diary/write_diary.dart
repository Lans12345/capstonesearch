import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:for_you/screens/diary/read_diary.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'package:intl/intl.dart';
import 'package:get_storage/get_storage.dart';
import '../../services/cloud_function/postDiary.dart';
import 'package:get/get.dart';

import '../../services/error.dart';
import '../../widgets/dialog.dart';
import '../../widgets/text.dart';
import '../home.dart';

class WriteDiary extends StatefulWidget {
  @override
  State<WriteDiary> createState() => _WriteDiaryState();
}

class _WriteDiaryState extends State<WriteDiary> {
  var date = 'Not Selected';

  bool showDateTime = false;
  DateTime selectedDate = DateTime.now();

  GetStorage box = GetStorage();

  Future<DateTime> _selectDate() async {
    final selected = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != selectedDate) {
      setState(() {
        selectedDate = selected;
      });
    }
    return selectedDate;
  }

  String getDate() {
    if (selectedDate == null) {
      return 'select date';
    } else {
      return DateFormat('MM-dd-yyyy').format(selectedDate);
    }
  }

  var title = '';
  var content = '';

  Widget selectDate() {
    if (getDate() == null) {
      return const Text(
        'DATE NOT SET',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      );
    } else {
      return Text(
        getDate(),
        style: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 12.0,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: textBold('Self Diary', 24, Colors.white),
          centerTitle: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [
                Colors.blue!,
                Colors.blue[400]!,
                Colors.blue[600]!,
              ]),
            ),
          ),
          bottom: TabBar(tabs: [
            textBold('Diaries', 18, Colors.white),
            textBold('Write Diary', 18, Colors.white),
          ]),
        ),
        body: TabBarView(children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('Diary')
                  .where('name', isEqualTo: box.read('name'))
                  .snapshots(),
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
                  height: 300,
                  child: GridView.builder(
                      itemCount: snapshot.data?.size ?? 0,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            box.write('diary_title', data.docs[index]['title']);
                            box.write('diary_date', data.docs[index]['date']);
                            box.write(
                                'diary_content', data.docs[index]['content']);
                            Get.to(() => ReadDiary());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Container(
                              height: 80,
                              width: 100,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Colors.blue,
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          FirebaseFirestore.instance
                                              .collection('Diary')
                                              .doc(data.docs[index]['date'])
                                              .delete();
                                        },
                                        icon: const Icon(Icons.delete),
                                        color: Colors.white,
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  textReg(data.docs[index]['date'], 12,
                                      Colors.white),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  textBold(data.docs[index]['title'], 18,
                                      Colors.white),
                                  const SizedBox(
                                    height: 50,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      }),
                );
              }),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.blue,
                  onPressed: () {
                    _selectDate();
                  },
                  child: textBold('Select Date', 14, Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                selectDate(),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    style: const TextStyle(
                        color: Colors.grey, fontFamily: 'Quicksand'),
                    onChanged: (_input) {
                      title = _input;
                    },
                    decoration: InputDecoration(
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
                      labelText: 'Title',
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
                  padding: const EdgeInsets.fromLTRB(50, 10, 50, 10),
                  child: TextFormField(
                    maxLines: 8,
                    style: const TextStyle(
                        color: Colors.grey, fontFamily: 'Quicksand'),
                    onChanged: (_input) {
                      content = _input;
                    },
                    decoration: InputDecoration(
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
                      labelText: 'Content',
                      labelStyle: const TextStyle(
                        fontFamily: 'Quicksand',
                        color: Colors.black,
                        fontSize: 12.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                MaterialButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  color: Colors.blue,
                  onPressed: () async {

                      postDiary(
                          title,
                          content,
                          getDate(),
                          box.read('name'),
                          box.read('contactNumber'),
                          // box.read('address'),
                          box.read('profilePicture'));
                      dialog('Upload Status', 'Uploaded Successfully!',
                          HomePage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(80, 10, 80, 10),
                    child: textBold('Post', 14, Colors.white),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
