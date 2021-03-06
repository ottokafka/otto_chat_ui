import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mac_chat/Messages.dart';
import 'package:mac_chat/SignUp.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'Actions/login.dart';
import 'main.dart';

class Login extends StatelessWidget {
  static const String id = "Login";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LoginUser(),
        ),
        Expanded(
          child: SignUp(),
        )
      ],
    );
  }
}

class LoginUser extends StatefulWidget {
  @override
  _LoginUserState createState() => _LoginUserState();
}

class _LoginUserState extends State<LoginUser> {
  String email = "";
  String password = "";

// //  String tokenUser;
  checkToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("token");

    print("The token is: $token");
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
    final appState = Provider.of<UserState>(context);
    appState.fetchUser();
    checkToken();
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Login"),
            TextFormField(
              validator: (value) {
                return nameValidator(value);
              },
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
            TextFormField(
              validator: (value) {
                return nameValidator(value);
              },
              obscureText: true,
              onChanged: (value) {
                password = value;
              },
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                hintText: 'Enter your 4 digit pin ex: 1234',
                labelText: 'a 4 digit Pin',
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
              child: Text("Login "),
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
                  await prefs.setString("user", email);
                  appState.fetchUser();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Messages(),
                    ),
                  );
                }
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
            Navigator.pop(context);
          },
          width: 120,
        )
      ],
    ).show();
  }
}

String nameValidator(value) {
  if (value.isEmpty) {
    return 'Please enter your name';
  } else {
    return "";
  }
}
