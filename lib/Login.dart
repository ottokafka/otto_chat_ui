import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
//   checkToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String tokenUser = (prefs.getString("tokenUser"));
//     String tokenBusiness = (prefs.getString("tokenBusiness"));
//     print("The tokenUser is: $tokenUser");
//     if (tokenUser != null) {
//       Navigator.pushNamed(context, DashboardUser.id);
//     }
//     if (tokenBusiness != null) {
//       Navigator.pushNamed(context, DashboardBusiness.id);
//     }
//   }

  @override
  Widget build(BuildContext context) {
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
                icon: Icon(Icons.email),
                hintText: 'Enter your email to login!',
                labelText: 'Email *',
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
                labelText: 'Password',
              ),
            ),
            TextButton(
                onPressed: () {
                  print("forgot password");
                  Navigator.pushNamed(context, Chat.id);
                },
                child: Text("Forgot password")),
            SizedBox(height: 20),
            CupertinoButton.filled(
              child: Text("Login"),
              onPressed: () {
                secondFunction() async {
                  // await loginUser(email, password);
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

  // alert() {
  //   Alert(
  //     context: context,
  //     type: AlertType.error,
  //     title: "Login",
  //     desc: "Sorry, Invalid Credentials.",
  //     buttons: [
  //       DialogButton(
  //         child: Text(
  //           "Try Again",
  //           style: TextStyle(color: Colors.white, fontSize: 20),
  //         ),
  //         onPressed: () => Navigator.pop(context),
  //         width: 120,
  //       )
  //     ],
  //   ).show();
  // }
}
