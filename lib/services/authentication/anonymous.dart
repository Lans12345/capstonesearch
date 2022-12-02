import 'package:firebase_auth/firebase_auth.dart';
//gi allow nako nga mag signin anonymous para instant siya
Future signIn() async {
  FirebaseAuth.instance.signInAnonymously();
}
