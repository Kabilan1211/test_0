// ignore_for_file: camel_case_types, file_names

// This is user model that the data has to be inserted into the database, if needed

class UserModel{
  final String? id;
  final String name;
  final String email;
  final String password;
  final int resetPassState;

  const UserModel({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    required this.resetPassState,
  });

  toJson(){
    return{
      "Name": name,
      "Email": email,
      "Password": password,
      "ResetState": resetPassState
    };
  }
}