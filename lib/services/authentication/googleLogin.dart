import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:get_storage/get_storage.dart';

import '../../screens/home.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

void logInWithGoogle() async {
  final box = GetStorage();
  try {
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount == null) {
      return;
    }
    final googleSignInAuth = await googleSignInAccount.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuth.accessToken,
      idToken: googleSignInAuth.idToken,
    );
    box.write('name', googleSignInAccount.displayName);
    box.write('contactNumber', googleSignInAccount.email);
    box.write('profilePicture', googleSignInAccount.photoUrl);
    await FirebaseAuth.instance.signInWithCredential(credential);
    Get.off(() => HomePage());
  } on FirebaseAuthException catch (e) {
    print(e);
  }
}
