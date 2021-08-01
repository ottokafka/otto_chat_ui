import 'package:flutter/material.dart';
import 'package:mac_chat/Messages.dart';
import 'package:provider/provider.dart';

import 'Add_Contact.dart';
import 'All_Contacts.dart';
import 'Chat.dart';
import 'Login.dart';
import 'config.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider<UserState>(create: (_) => UserState()),
      ],
      child: OttoChat(),
    ));

class OttoChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    initailizeApp();
    return MaterialApp(
      initialRoute: Messages.id,
      routes: {
        // User
        // Chat.id: (context) => Chat(),
        Login.id: (context) => Login(),
        Messages.id: (context) => Messages(),
        AllContacts.id: (context) => AllContacts(),
        AddContact.id: (context) => AddContact(),
      },
    );
  }
}
