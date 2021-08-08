import 'package:flutter/material.dart';
import 'package:mac_chat/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: TextButton.icon(
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove("token");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Login(),
              ),
            );
          },
          icon: Icon(Icons.logout),
          label: Text("Logout")),
    );
  }
}
