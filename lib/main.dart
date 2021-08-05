import 'package:flutter/material.dart';
import 'package:mac_chat/LoadContacts.dart';
import 'package:mac_chat/Messages.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Add_Contact.dart';
import 'Chat.dart';
import 'Login.dart';
import 'config.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(create: (context) => UserState()),
      ],
      child: OttoChat(),
    ));

class OttoChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<UserState>(context);
    initailizeApp();
    // appState.setStateContacts();
    return MaterialApp(
      initialRoute: Messages.id,
      routes: {
        // User
        // Chat.id: (context) => Chat(),
        Login.id: (context) => Login(),
        Messages.id: (context) => Messages(),
        AddContact.id: (context) => AddContact(),
        LoadContacts.id: (context) => LoadContacts(),
      },
    );
  }
}

// Provider
class UserState with ChangeNotifier {
  UserState();

  List<String> _contactsList = ["otto"];

  Future get fetchContacts async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var list = prefs.getStringList("contacts");

    var futureList = Future.value(list);

    for (var i = 0; i < list!.length; i++) {
      // check list if contact already exists if so dont add
      if (_contactsList.contains(list[i])) {
        print("dont add");
      } else {
        _contactsList.add(list[i]);
      }
    }
    print("contactList $_contactsList");

    return futureList;
  }

  void setStateContacts() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? list = prefs.getStringList("contacts");
    print(list);

    // _contactsList = list;
    for (var i = 0; i < list!.length; i++) {
      // check list if contact already exists if so dont add
      if (_contactsList.contains(list[i])) {
        print("dont add");
      } else {
        _contactsList.add(list[i]);
      }
    }
  }

  void setContactsList(String user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // Get saved list of contacts
    List<String>? hddList = prefs.getStringList("contacts");

    if (_contactsList.contains(user)) {
      print("dont add user already added");
      if (hddList!.contains(user)) {
        print("user already saved locally");
      }
      // add user to contact list if not there
    } else {
      _contactsList.add(user);
    }

    print("on add contact this goes off rebuild");
    print(hddList);
    print("setuser " + user);
    // Save our current list to the device
    await prefs.setStringList("contacts", _contactsList);
    print(prefs.getStringList("contacts"));
    print("contact list updated to: ${_contactsList}");
    notifyListeners();
  }

  List<String>? get getContactsList => _contactsList;
}
