
// ignore_for_file: file_names, override_on_non_overriding_member, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, annotate_overrides, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:test_0/main.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/widgets/textField.dart';

// This page is used to reset the password

class ResetPass extends StatefulWidget {
  const ResetPass({Key? key}) : super(key: key);

  @override
  State<ResetPass> createState() => _ResetPassState();
}

class _ResetPassState extends State<ResetPass> {

  //Assigning the values entered in the form field to a final variable
  final _passwordController = TextEditingController();
  final _resetPassword = TextEditingController();
  final _checker = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    //Function to validate the password
    final AuthService _auth = AuthService();
    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Enter a password';
      } else if (!isPasswordStrong(value)) {
        return 'Password must be at least 8 characters long and contain uppercase, lowercase, digits, and special characters';
      }
      return null;
    }

    void _updatePassword(){
      _auth.resetPassword(emailId, _passwordController.text,_checker.text);
    }

    void dispose(){
      _passwordController.text = "";
      _resetPassword.text = "";
      _checker.text = "";
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text("Reset Password"),
        centerTitle: true,
      ),
      backgroundColor: Colors.grey[200],
      body: Container(
        height: MediaQuery.of(context).size.height * 0.8,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 50),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),
              CustomTextField1(
                controller: _passwordController,
                hintText: "Enter your old password",
                secureText: true,
                validator: (val) {
                  if (val == null || val.isEmpty) {
                    return 'Enter your old password';
                  }
                  // Perform any additional validation if needed
                  return null;
                },
              ),
              CustomTextField1(
                  controller: _resetPassword,
                  hintText: "Enter your new password",
                  secureText: true,
                  validator: _validatePassword),
              CustomTextField1(
                controller: _checker,
                hintText: "Enter your new password again",
                secureText: true,
                validator: (val) {
                  // print(val);
                  if (val == null || val.isEmpty) {
                    return 'Re-enter your new password';
                  } else if (val != _resetPassword.text) {
                    return "Passwords don't match";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 30,
              ),
              ElevatedButton(
                onPressed: () {
                  //Validating the form
                  if (_formKey.currentState!.validate()) {
                    //Checking that the new password entered correctly for twice
                    if (_resetPassword.text == _checker.text) {
                      //Checking that the new password is not old password
                      if (_passwordController.text != _checker.text) {
                        // This function is used to update the password in the user                        
                        _updatePassword(); 
                        // This function is used to update the password and reset state in the database
                        updateData(_checker.text);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const MyHomePage()));
                      }
                    }
                  }
                  else{
                    dispose();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade200,
                ),
                child: const Text("Reset Password"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
