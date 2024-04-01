// ignore_for_file: non_constant_identifier_names, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:test_0/Model/UserModel.dart';

// This page contains code related to CRUD operation on the database

class DatabaseService{

  final String uid;
  DatabaseService({required this.uid});

//collection reference
final CollectionReference UserDataBase = FirebaseFirestore.instance.collection('Users');

// Function Used to update the userdata in the database
Future updateUserData(String name) async{
  try{

return await UserDataBase.doc(uid).set({
  'Name' : name,
});
  }
  catch(e){
    print(e.toString());
    return null;
  }
}

// Function used to write the data into the database 
Future AddUser()async{
    await UserDataBase.add(UserModel(firstName: "Kabilan S", lastName: "s", emailId: "", username: "", password: "", validUser: "", resetPassword: ""));
}

}