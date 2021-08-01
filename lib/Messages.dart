import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Actions/add_contact.dart';
import 'Add_Contact.dart';
import 'Chat.dart';
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
          ],
        ),
      ),
    );
  }
}

class LoadContacts extends StatefulWidget {
  const LoadContacts({Key? key}) : super(key: key);

  @override
  _LoadContactsState createState() => _LoadContactsState();
}

class _LoadContactsState extends State<LoadContacts> {
  var contactsList = [];

  @override
  void initState() {
    super.initState();

    loadContacts() async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      List<String>? list = prefs.getStringList("contacts");
      setState(() => {
            reload = false,
            for (var i = 0; i < list!.length; i++) {contactsList.add(list[i])}
          });
    }

    loadContacts();
  }

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: contactsList.length,
      itemBuilder: (context, index) {
        return ListTile(
          // title: Text(contactsList[index]),
          title: TextButton.icon(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Chat(
                      user: "otto",
                      user2: contactsList[index],
                    ),
                  ),
                );
              },
              icon: Icon(Icons.person),
              label: Text(contactsList[index])),
        );
      },
    );
  }
}
