import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_chat/Messages.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Actions/login.dart';
import 'Chat.dart';

class Login extends StatelessWidget {
  static const String id = "Login";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginUser(),
    );
  }
}

class LoginUser extends StatefulWidget {
  static const String id = "LoginUser";

  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  late String email;
  late String password;

// //  String tokenUser;
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    print("The tokenUser is: $token");
    if (token != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Messages(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Check token for automated login
    checkToken();
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                filled: true,
                icon: Icon(Icons.person),
                hintText: 'Enter your user name to login!',
                labelText: 'Name *',
              ),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(height: 20),
            TextField(
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                hintText: 'Enter your 4 digit pin 1234',
                labelText: 'Pin',
              ),
            ),
            TextButton(
                onPressed: () {
                  print("forgot password");
                  // Navigator.pushNamed(context, Chat.id);
                },
                child: Text("Forgot password")),
            SizedBox(height: 20),
            CupertinoButton.filled(
              child: Text("Login"),
              onPressed: () async {
                await loginUser(email, password);
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String? message = prefs.getString("message");
                print(message);

                if (message == "Invalid Credentials") {
                  print("alert message");
                  alert();
                  prefs.remove("message");
                } else {
                  // Navigator.pushNamed(context, Messages.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messages(),
                    ),
                  );
                }

                secondFunction() async {
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

  alert() {
    Alert(
      context: context,
      type: AlertType.error,
      title: "Login",
      desc: "Sorry, Invalid Credentials.",
      buttons: [
        DialogButton(
          child: Text(
            "Try Again",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () async {
            // Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}
