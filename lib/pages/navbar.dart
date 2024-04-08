// ignore_for_file: file_names, unnecessary_string_interpolations, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:test_0/pages/Login.dart';
import 'package:test_0/pages/help.dart';
import 'package:test_0/pages/updatePassword.dart';
import 'notification.dart';

// This is Navigation drawer page

class NavBar extends StatelessWidget {
  const NavBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    //Returning a drawer to access various page route from the home page itself
    return Drawer(
      backgroundColor: Colors.blue.shade200,
      child: ListView(
          padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
          children: const <Widget>[
            Center(
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/profile.jpg'),
                radius: 50,
              ),
            ),
            Divider(height: 50, color: Colors.blue),
            Text(
              'NAME',
              style: TextStyle(
                color: Colors.blue,
                letterSpacing: 2.0,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Kabilan S',
              style: TextStyle(
                color: Colors.blue,
                letterSpacing: 2.0,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              height: 20,
            ),
            Tile(icons:Icon(Icons.help), text: "Help", fun: HelpPage()),
          ]),
    );
  }
}

//Creating a class "Tile" to display in the Navigation drawer
class Tile extends StatelessWidget {
  const Tile(
      {super.key, required this.icons, required this.text, required this.fun});
  final Widget? icons;
  final String text;
  final Widget fun;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(
          color: Colors.blue,
        ),
        ListTile(
          title: Text(text),
          leading: icons ??
              const Icon(
                Icons.abc,
                color: Colors.blue,
              ),
          iconColor: Colors.blue,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => fun),
          ),
        ),
      ],
    );
  }
}
