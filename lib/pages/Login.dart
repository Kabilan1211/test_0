// ignore_for_file: use_build_context_synchronously, file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:test_0/Cloud/Auth.dart';
import 'package:test_0/Cloud/database.dart';
import 'package:test_0/main.dart';
import 'package:test_0/pages/updatePassword.dart';
import 'package:test_0/widgets/textField.dart';
String emailId = "";
String password = "";

// This page contains the code for login page

// Function to check the password is strong or not
bool isPasswordStrong(String password) {
  const minLength = 8;
  final hasUppercase = RegExp(r'[A-Z]').hasMatch(password);
  final hasLowercase = RegExp(r'[a-z]').hasMatch(password);
  final hasDigits = RegExp(r'\d').hasMatch(password);
  final hasSpecialChars = RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password);

  return password.length >= minLength &&
      hasUppercase &&
      hasLowercase &&
      hasDigits &&
      hasSpecialChars;
}

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _auth = AuthService();
  String errorText = "";

  // Function  to validate the email address format
    String? _validateEmail(String? value) {
      final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
      if (!emailRegex.hasMatch(value!)) {
        return 'Enter a valid email address';
      }
      return null;
    }

  // Function to validate the password is strong
    String? _validatePassword(String? value) {
      if (value == null || value.isEmpty) {
        return 'Enter a password';
      } else if (!isPasswordStrong(value)) {
        return 'Password must be at least 8 characters long and contain uppercase, lowercase, digits, and special characters';
      }
      return null;
    }


  @override
  Widget build(BuildContext context) {

    // This code is the front end of the login page
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade200,
        title: const Text("LOGIN"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height *0.8,
          width: double.infinity,
          padding: const EdgeInsets.all(10),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                CustomTextField1(
                  controller: _emailController,
                  hintText: "Enter your Email",
                  secureText: false, 
                  validator: _validateEmail),
                const SizedBox(height: 20,),
                CustomTextField1(
                  controller: _passwordController, 
                  hintText: "Enter your password", 
                  secureText: true, 
                  validator: _validatePassword),
                const SizedBox(height: 20,),
                ElevatedButton(
                  onPressed: () async {

                    // This function happens when the login button is pressed and it will validate the forms
                    if(_formKey.currentState!.validate()){
                      setState(() {
                        emailId = _emailController.text;
                        password = _passwordController.text;
                      });

                      // It will fetch the reset state from the database
                      fetchData(emailId);
                      // It will login the user and store the result in the variable result
                      dynamic result = await _auth.logIn(emailId, password);
                      print(result);

                      // If the result is null, means the user entered wrong credentials and it will display the errorText
                      if(result == null){
                      setState(() {
                        errorText = "Bad Credentials";
                        print("Bad Credentials");
                      });
                      }

                    else{

                      // if the reset state is zero then the user will be navigated to the home screen
                      if(resetPass == 0){
                        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=> const MyHomePage()));
                      }
                      // if the reset state is one then the user will be navigated to the reset password page
                      else{
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ResetPass()));
                      }
                    }
                    }
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blue), 
                  child: const Text("Login"),
                  ),
                const SizedBox(height: 10,),
                Text(errorText, style: const TextStyle(color: Colors.red),)
              ],
            ),
             ),
        ),
      ),
    );
  }
}