import 'package:cloud_firestore/cloud_firestore.dart';

Future postDiary(
  String title,
  String content,
  String date,
  String name,
  String contactNumber,
  String profilePicture,
) async {
  final docUser = FirebaseFirestore.instance.collection('Diary').doc(date);

  final json = {
    'title': title,
    'content': content,
    'date': date,
    'name': name,
    'contactNumber': contactNumber,
    'profilePicture': profilePicture,
  };

  await docUser.set(json);
}
