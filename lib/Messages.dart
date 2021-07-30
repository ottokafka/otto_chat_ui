import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'Chat.dart';

// TODO: Get users for Otto from API and load them here or
// TODO: Get users from local storage and load them
class Messages extends StatelessWidget {
  static const String id = "Messages";
  late String user;
  late String user2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              // Icon with text field

              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat(
                          user: "otto",
                          user2: "shen",
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.person),
                  label: Text("Shen")),

              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat(
                          user: "otto",
                          user2: "shen2",
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.person),
                  label: Text("Shen2")),

              TextButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Chat(
                          user: "otto",
                          user2: "shen3",
                        ),
                      ),
                    );
                  },
                  icon: Icon(Icons.person),
                  label: Text("Shen3")),

              SizedBox(height: 20),
              CupertinoButton.filled(
                child: Text("Login"),
                onPressed: () {
                  startChat() async {
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

                  startChat();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
