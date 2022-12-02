import 'package:cloud_firestore/cloud_firestore.dart';
//Asynchronous programming is a technique that enables your program to start a potentially
// long-running task and still be able to be responsive to other events while that
// task runs, rather than having to wait until that task has finished.
// Once that task has finished, your program is presented with the result.
Future addAnxiety(String name, String contactNumber, String result,
    String profilePicture) async {
  final docUser = FirebaseFirestore.instance.collection('Data').doc();

  final json = {
    'name': name,
    'contactNumber': contactNumber,
    'result': result,
    'profilePicture': profilePicture,
    'id': docUser.id,
    'type': 'Anxiety',
  };

  await docUser.set(json);
}
