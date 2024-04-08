// ignore_for_file: file_names, body_might_complete_normally_nullable, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/widgets/user.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:shared_preferences/shared_preferences.dart';

//This page is used to provide the authentication functions
String ? savedEmail = "";
class AuthService{

  // Function used to initialize the firebase
  static Future<void> initializeFirebase() async {
    await Firebase.initializeApp();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  var currentUser = FirebaseAuth.instance.currentUser;

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
    await _saveUserCredentials(email, password);
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

Future signOut() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Clear user credentials from local storage
    print(prefs);
    return await signOutUser();
  }

  // Function used to Reset Password
  resetPassword(String email, String oldPassword, String newPassword) async{
    var cred = EmailAuthProvider.credential(email: email,password: password);
    await currentUser!.reauthenticateWithCredential(cred).then((value) {
      currentUser!.updatePassword(newPassword);
    });
  }

    Future _saveUserCredentials(String email, String password) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('email', email);
    prefs.setString('password', password);
    print(email);
    print(password);
  }

    Future<Map<String, String>> getUserCredentials() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    savedEmail = prefs.getString('email');
    String? savedPassword = prefs.getString('password');
    return {'email': savedEmail ?? "", 'password': savedPassword ?? ""};
  }

}