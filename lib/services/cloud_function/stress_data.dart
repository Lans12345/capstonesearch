import 'package:cloud_firestore/cloud_firestore.dart';
//mao ni siya ang code para e reference sa pag get ug data gikan sa firestore
//let you automatically run backend code in response to events triggered by Firebase features and HTTPS requests.
// Your code is stored in Google's cloud and runs in a managed environment.
// There's no need to manage and scale your own servers.
Future addStress(String name, String contactNumber, String result,
    String profilePicture) async {
  final docUser = FirebaseFirestore.instance.collection('Data').doc();

  final json = {
    'name': name,
    'contactNumber': contactNumber,
    'result': result,
    'profilePicture': profilePicture,
    'id': docUser.id,
    'type': 'Stress',
  };

  await docUser.set(json);
}
