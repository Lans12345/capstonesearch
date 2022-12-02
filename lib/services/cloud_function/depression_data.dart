import 'package:cloud_firestore/cloud_firestore.dart';

Future addDepression(String name, String contactNumber, String result,
    String profilePicture) async {
  final docUser = FirebaseFirestore.instance.collection('Data').doc();

  final json = {
    'name': name,
    'contactNumber': contactNumber,
    'result': result,
    'profilePicture': profilePicture,
    'id': docUser.id,
    'type': 'Depression',
  };

  await docUser.set(json);
}
