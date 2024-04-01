// ignore_for_file: file_names, body_might_complete_normally_nullable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_0/widgets/user.dart';
import 'package:test_0/Cloud/database.dart';

//This page is used to provide the authentication functions

class AuthService{

  // Function used to initialize the firebase
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Function used to save the user unique ID
  CustomUser? _userFromFirebaseUser(User? user){
    return user != null ? CustomUser(uid: user.uid) : null;
  }

  // Function used to change te stream control based on the user UID
  Stream<CustomUser?> get userStream{
    return _auth.authStateChanges().map((_userFromFirebaseUser));
  }

  // Function used to register a new user
  Future<CustomUser?> register(String email, String password)async{
    try{
      UserCredential result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User? firebaseUser = result.user;
      await DatabaseService(uid: firebaseUser!.uid).updateUserData('Kabilan S');
      return _userFromFirebaseUser(firebaseUser);
    }
    catch(e){
      throw Exception("Registration failed. Please try again later");
    }
  }

  // Function used to Log In
   Future<CustomUser?> logIn(String email, String password) async {
  try {
    UserCredential result = await _auth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    User? firebaseUser = result.user; 
    return _userFromFirebaseUser(firebaseUser);
  } catch (e) {
    // throw Exception('Registration failed. Please try again.');
    print(e);
  }
}
  
  // Function used to Sign out
  signOutUser() async {
  try {
    await FirebaseAuth.instance.signOut();
    print('User logged out successfully');
  } catch (e) {
    print('Error logging out: $e');
  }
}

  // Function used to Reset Password
  Future resetPassword(String email) async{
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }

}