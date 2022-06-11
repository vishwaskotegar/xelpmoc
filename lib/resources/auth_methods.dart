import 'package:firebase_auth/firebase_auth.dart';

class AuthMethods {
  final _auth = FirebaseAuth.instance;
  Future<String> signup(
      {required String email, required String password}) async {
    String res = "Something went wrong!";
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      res = 'success';
    } on FirebaseAuthException catch (err) {
      if (err.code == 'invalid-email') {
        res = "email badly formated";
      } else if (err.code == 'weak-password') {
        res = 'weak password';
      }
    } catch (e) {
      res = e.toString();
    }

    return res;
  }

  Future<String> login(
      {required String email, required String password}) async {
    String res = "Unable to login";

    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      res = "success";
    } on FirebaseAuthException catch (err) {
      if (err.code == "user-not-found") {
        res = "Invalid Email";
      }
      if (err.code == "wrong-password") {
        res = "Wrong Password";
      }
    } catch (err) {
      res = err.toString();
    }
    return res;
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}
