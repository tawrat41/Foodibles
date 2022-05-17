// import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'Model/user.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();
  //checks if we are logged in or not
  Stream<MyUser> get user {
    return _firebaseAuth.authStateChanges().map(_userFromFirbaseUser);
  }

  //create user obj based on Firebase user
  MyUser _userFromFirbaseUser(User user) {
    return user != null ? MyUser(userId: user.uid) : null;
  }

  // Future signInAnonimously() async {
  //   try {
  //     UserCredential result = await _firebaseAuth.signInAnonymously();
  //     User user = result.user;
  //     return user;
  //   } on FirebaseAuthException catch (e) {
  //     print(e.message);
  //     return null;
  //   }
  // }

  Future signIn({String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User user = result.user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message.toString());
      return null;
    }
  }

  Future signUp({String email, String password}) async {
    try {
      User user = (await _firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user;
      return user;
    } on FirebaseAuthException catch (e) {
      print(e.message);
      return null;
    }
  }

  Future signOut() async {
    try {
      return await _firebaseAuth.signOut();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
