
// ignore_for_file: file_names, override_on_non_overriding_member, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, annotate_overrides, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/widgets/textField.dart';

// This page is used to reset the password

class UpdatePassword extends StatefulWidget {
  const UpdatePassword({super.key});

  @override
  State<UpdatePassword> createState() => _UpdatePasswordState();
}

class _UpdatePasswordState extends State<UpdatePassword> {
  @override

  final AuthService _auth = AuthService();
  final _emailControllerReset = TextEditingController();
  Widget build(BuildContext context) {

    String ResetEmail = "";

    String? _validateEmail(String? value) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value!)) {
        return 'Enter a valid email address';
      }
      return null;
    }

    Future <void> _resetPassword(String emailID) async {
      await _auth.resetPassword(emailID);
    }

    Future <void> _logout() async{
      await _auth.signOutUser();
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) => const LoginPage())));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade200,
        title: const Text("Update your password"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height*0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CustomTextField1(controller: _emailControllerReset, hintText: "Enter Email", secureText: false, validator: _validateEmail),
              ElevatedButton(onPressed: (){
                setState(() {
                  ResetEmail = _emailControllerReset.text;
                });
                _resetPassword(ResetEmail);
                _logout();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
               child: const Text("Reset Password"))
            ],
          ),
        ),
      ),
    );
  }
}