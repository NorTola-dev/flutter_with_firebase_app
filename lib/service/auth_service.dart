import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  // sign-up or register
  Future<User?> signUpAccount(String email, String password) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign-in or login
  Future<User?> loginAccount(String email, String password) async {
    try {
      final result = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<User?> signInWithGoogle() async {
    try {
      GoogleSignInAccount? accountUser = await GoogleSignIn().signIn();
      if (accountUser == null) {
        return null;
      }
      GoogleSignInAuthentication googleAuth = await accountUser.authentication;
      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );
      final result = await auth.signInWithCredential(credential);
      return result.user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
