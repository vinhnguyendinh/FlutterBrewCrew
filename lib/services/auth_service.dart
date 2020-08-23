import 'package:firebase_auth/firebase_auth.dart';
import 'package:brew_crew/models/user.dart';

class AuthService {
  final FirebaseAuth _authFir = FirebaseAuth.instance;

  UserModel _createUserFromUserCredential(User user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Auth change user stream
  Stream<UserModel> get user {
    try {
      return _authFir.authStateChanges().map(_createUserFromUserCredential);
    } catch (err) {
      print(err.toString());
      return null;
    }
  }

  // Sign in
  Future<UserModel> handleSignInEmail({email, password}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return _createUserFromUserCredential(user.user);
    } catch (err) {
      if (err.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (err.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      return null;
    }
  }

  // Sign up
  Future<UserModel> handleSignUp({email, password}) async {
    try {
      UserCredential user = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return _createUserFromUserCredential(user.user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      return null;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // Sing out
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
