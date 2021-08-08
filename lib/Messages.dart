import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Actions/add_contact.dart';
import 'Add_Contact.dart';
import 'Chat.dart';
import 'LoadContacts.dart';
import 'Logout.dart';
import 'globals.dart';

// TODO: Get users for Otto from API and load them here or
// TODO: Get users from local storage and load them
class Messages extends StatelessWidget {
  static const String id = "Messages";
  late String user;
  late String user2;

// Load contacts dynamically from local stoarge
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            // Icon with text field
            Expanded(child: LoadContacts()),

            SizedBox(height: 150),

            Expanded(child: AddContact()),
            Logout()
          ],
        ),
      ),
    );
  }
}
