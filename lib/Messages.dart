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
import 'main.dart';

// TODO: Get users for Otto from API and load them here or
// TODO: Get users from local storage and load them
class Messages extends StatelessWidget {
  static const String id = "Messages";
  late String user;
  late String user2;

// Load contacts dynamically from local stoarge
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<UserState>(context);

    appState.fetchToken();
    appState.fetchUser();

    return Scaffold(
      body: Column(
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Hi ${appState.user!}',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  '-- Contacts --',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
          Expanded(child: LoadContacts()),
          SizedBox(height: 150),
          Container(
            child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddContact(),
                    ),
                  );
                },
                icon: Icon(Icons.add),
                label: Text(" Add a new contact ")),
          ),
          Logout()
        ],
      ),
    );
  }
}
