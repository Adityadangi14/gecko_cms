import 'package:firebase_auth/firebase_auth.dart';

class GoogleLoginService {
  static Future<UserCredential> signWebInWithGoogle() async {
    GoogleAuthProvider googleProvider = GoogleAuthProvider();
    googleProvider.setCustomParameters({'login_hint': 'user@example.com'});
    return await FirebaseAuth.instance.signInWithPopup(googleProvider);
  }
}
