import 'package:flutter/material.dart';
import 'package:mac_chat/Messages.dart';

import 'Chat.dart';
import 'Login.dart';

void main() => runApp(OttoChat());

class OttoChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: Messages.id,
      routes: {
        // User
        // Chat.id: (context) => Chat(),
        Login.id: (context) => Login(),
        Messages.id: (context) => Messages(),
      },
    );
  }
}
