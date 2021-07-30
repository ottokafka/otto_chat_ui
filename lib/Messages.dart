import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';

class Messages extends StatelessWidget {
  static const String id = "Messages";
  late String user;
  late String user2;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                icon: Icon(Icons.people),
                hintText: 'user name!',
                labelText: 'User *',
              ),
              onChanged: (value) {
                user = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                icon: Icon(Icons.people),
                hintText: 'user2 name!',
                labelText: 'User2 *',
              ),
              onChanged: (value) {
                user2 = value;
              },
            ),
            SizedBox(height: 20),
            CupertinoButton.filled(
              child: Text("Login"),
              onPressed: () {
                secondFunction() async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Chat(
                        user: "otto",
                        user2: "shen2",
                      ),
                    ),
                  );

                  // await MessagesSetup(email, password);
                  // SharedPreferences prefs =
                  //     await SharedPreferences.getInstance();
                  // String msg = prefs.getString("msg");

                  // if (msg == "Invalid Credentials") {
                  //   print("alert message");
                  //   alert();
                  //   prefs.remove("msg");
                  // }
                  // checkToken();
                }

                secondFunction();
              },
            ),
          ],
        ),
      ),
    );
  }
}
