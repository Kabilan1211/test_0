// ignore_for_file: await_only_futures, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:test_0/Cloud/messaging.dart';
import 'package:test_0/Model/UserModel.dart';
import 'package:test_0/main.dart';

int resetPass = 0;
String docId = "";
class UserRepo extends GetxController {
  static UserRepo get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  createUser(UserModel user){
    _db.collection('Users').add(user.toJson()).whenComplete(() => print("Success"));

  }
}

Future<void> fetchData(String email) async {
final QuerySnapshot<Map<String,dynamic>> data = await FirebaseFirestore.instance.collection("Users").where("Email", isEqualTo: email).get();
final QueryDocumentSnapshot<Map<String, dynamic>> reqData = data.docs[0];
docId = reqData.id;
// print(docId);
resetPass = reqData.data()['ResetState'];
}

Future<void> updateData(String password) async {
final DocumentReference<Map<String,dynamic>> data = await FirebaseFirestore.instance.collection("Users").doc(docId);
data.update(
  {
    "ResetState": 0,
    "Password": password
  }
);
}

Future<void> fetchLast5Data() async {
  final QuerySnapshot<Map<String,dynamic>> data = await FirebaseFirestore.instance.collection("Notification").get();
  int length = data.size;
  // print(length);
  final QueryDocumentSnapshot<Map<String,dynamic>> reqData1 = data.docs[length-1];
  title1 = reqData1.data()['Title'];
  body1 = reqData1.data()['Body'];
  time1 = reqData1.data()['Time'];
  // print(reqData1.data());
  final QueryDocumentSnapshot<Map<String,dynamic>> reqData2 = data.docs[length-2];
  title2 = reqData2.data()['Title'];
  body2 = reqData2.data()['Body'];
  time2 = reqData2.data()['Time'];
  // print(reqData2.data());
  final QueryDocumentSnapshot<Map<String,dynamic>> reqData3 = data.docs[length-3];
  title3 = reqData3.data()['Title'];
  body3 = reqData3.data()['Body'];
  time3 = reqData3.data()['Time'];
  // print(reqData3.data());
  final QueryDocumentSnapshot<Map<String,dynamic>> reqData4 = data.docs[length-4];
  title4 = reqData4.data()['Title'];
  body4 = reqData4.data()['Body'];
  time4 = reqData4.data()['Time'];
  // print(reqData4.data());
  final QueryDocumentSnapshot<Map<String,dynamic>> reqData5 = data.docs[length-5];
  title5 = reqData5.data()['Title'];
  body5 = reqData5.data()['Body'];
  time5 = reqData5.data()['Time'];
  // print(reqData5.data());

  // print(title1);
  // print(title2);
  // print(title3);
  // print(title4);
  // print(title5);

  Future.delayed(const Duration(seconds: 2), fetchLast5Data);
  // navigatorKey.currentState?.pushReplacementNamed('/home');
  }