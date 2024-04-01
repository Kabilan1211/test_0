// To parse this JSON data, do
//
//     final userModel = userModelFromJson(jsonString);

// ignore_for_file: file_names

//This is user model page that is used to push data into the firebase

import 'dart:convert';

UserModel userModelFromJson(String str) => UserModel.fromJson(json.decode(str));

String userModelToJson(UserModel data) => json.encode(data.toJson());

class UserModel {
    String firstName;
    String lastName;
    String emailId;
    String username;
    String password;
    String validUser;
    String resetPassword;

    UserModel({
        required this.firstName,
        required this.lastName,
        required this.emailId,
        required this.username,
        required this.password,
        required this.validUser,
        required this.resetPassword,
    });

    factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        firstName: json["First Name"],
        lastName: json["Last Name"],
        emailId: json["Email ID"],
        username: json["Username"],
        password: json["Password"],
        validUser: json["Valid User"],
        resetPassword: json["ResetPassword"],
    );

    Map<String, dynamic> toJson() => {
        "First Name": firstName,
        "Last Name": lastName,
        "Email ID": emailId,
        "Username": username,
        "Password": password,
        "Valid User": validUser,
        "ResetPassword": resetPassword,
    };
}
